const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();

// Utilities
function generateOtp() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

function nowPlus(minutes) {
  const expires = new Date();
  expires.setMinutes(expires.getMinutes() + minutes);
  return expires.toISOString();
}

// Callable: request OTP for password reset
exports.requestOtp = functions.https.onCall(async (data, context) => {
  const email = (data && data.email || '').toString().trim().toLowerCase();
  if (!email) {
    throw new functions.https.HttpsError('invalid-argument', 'Email required');
  }

  const otp = generateOtp();
  const expiresAt = nowPlus(10); // 10 minutes

  await db.collection('password_resets').doc(email).set({
    email,
    otp,
    expiresAt,
    createdAt: new Date().toISOString(),
  });

  // For demo: we return the OTP so the app can display it
  // In production, send email via an SMTP provider and DO NOT return OTP
  return { otp };
});

// Callable: verify OTP and update password
exports.verifyOtpAndReset = functions.https.onCall(async (data, context) => {
  const email = (data && data.email || '').toString().trim().toLowerCase();
  const otp = (data && data.otp || '').toString().trim();
  const newPassword = (data && data.newPassword || '').toString();

  if (!email || !otp || !newPassword) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing fields');
  }

  const docSnap = await db.collection('password_resets').doc(email).get();
  if (!docSnap.exists) {
    throw new functions.https.HttpsError('not-found', 'No OTP request found');
  }
  const { otp: savedOtp, expiresAt } = docSnap.data();
  const expired = new Date(expiresAt).getTime() < Date.now();

  if (expired) {
    throw new functions.https.HttpsError('deadline-exceeded', 'OTP expired');
  }
  if (otp !== savedOtp) {
    throw new functions.https.HttpsError('permission-denied', 'Invalid OTP');
  }

  const user = await admin.auth().getUserByEmail(email);
  await admin.auth().updateUser(user.uid, { password: newPassword });

  await db.collection('password_resets').doc(email).delete();
  return { ok: true };
});

// Callable: create booking
exports.createBooking = functions.https.onCall(async (data, context) => {
  const booking = {
    bookingNo: (data.bookingNo || '').toString(),
    user: (data.user || '').toString(),
    phone: (data.phone || '').toString(),
    event: (data.event || '').toString(),
    planner: (data.planner || '').toString(),
    date: (data.date || '').toString(), // ISO string
    amount: (data.amount || '').toString(),
    coupon: (data.coupon || '').toString(),
    status: 'Pending',
    createdAt: new Date().toISOString(),
  };

  const ref = await db.collection('bookings').add(booking);
  await ref.update({ id: ref.id });
  return { id: ref.id };
});

// Callable: list all bookings (for admin)
exports.getAllBookings = functions.https.onCall(async (data, context) => {
  const snap = await db.collection('bookings').orderBy('date').get();
  const bookings = snap.docs.map(d => ({ id: d.id, ...d.data() }));
  return { bookings };
});

// Callable: update booking status (for admin)
exports.updateBookingStatus = functions.https.onCall(async (data, context) => {
  const id = (data && data.id || '').toString();
  const status = (data && data.status || '').toString();
  if (!id || !status) {
    throw new functions.https.HttpsError('invalid-argument', 'Missing id/status');
  }
  await db.collection('bookings').doc(id).update({ status });
  return { ok: true };
});