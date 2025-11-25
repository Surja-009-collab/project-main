import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class LocalDbService {
  LocalDbService._();
  static final LocalDbService instance = LocalDbService._();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final basePath = await getDatabasesPath();
    final path = p.join(basePath, 'eventify.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // Core tables
        await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT UNIQUE,
            phone TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS venues (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            location TEXT,
            capacity INTEGER,
            price REAL,
            image TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user TEXT NOT NULL,
            event TEXT NOT NULL,
            date TEXT NOT NULL,
            status TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS favourites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTxEGER NOT NULL,
            venue_id INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS payments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            booking_id INTEGER NOT NULL,
            amount REAL NOT NULL,
            status TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Additive migrations
        await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT UNIQUE,
            phone TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS venues (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            location TEXT,
            capacity INTEGER,
            price REAL,
            image TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS favourites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            venue_id INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS payments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            booking_id INTEGER NOT NULL,
            amount REAL NOT NULL,
            status TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> _seedIfEmpty() async {
    final database = await db;
    final bookingsCount = Sqflite.firstIntValue(
          await database.rawQuery('SELECT COUNT(*) FROM bookings'),
        ) ??
        0;
    if (bookingsCount == 0) {
      final batch = database.batch();
      batch.insert('bookings', {
        'user': 'Rima Shah',
        'event': 'Wedding Reception',
        'date': '2025-10-10',
        'status': 'Pending',
      });
      batch.insert('bookings', {
        'user': 'Arjun Patel',
        'event': 'Birthday Party',
        'date': '2025-10-15',
        'status': 'Approved',
      });
      batch.insert('bookings', {
        'user': 'Neha Gupta',
        'event': 'Corporate Event',
        'date': '2025-09-30',
        'status': 'Rejected',
      });
      await batch.commit(noResult: true);
    }
    final usersCount = Sqflite.firstIntValue(
          await database.rawQuery('SELECT COUNT(*) FROM users'),
        ) ??
        0;
    if (usersCount == 0) {
      final batch = database.batch();
      batch.insert('users', {
        'name': 'Admin User',
        'email': 'admin@example.com',
        'phone': '9999999999',
      });
      batch.insert('users', {
        'name': 'Test User',
        'email': 'user@example.com',
        'phone': '8888888888',
      });
      await batch.commit(noResult: true);
    }
    final venuesCount = Sqflite.firstIntValue(
          await database.rawQuery('SELECT COUNT(*) FROM venues'),
        ) ??
        0;
    if (venuesCount == 0) {
      final batch = database.batch();
      batch.insert('venues', {
        'name': 'Grand Palace',
        'location': 'City Center',
        'capacity': 300,
        'price': 50000,
        'image': '',
      });
      batch.insert('venues', {
        'name': 'Lakeside Hall',
        'location': 'Near Lakeview',
        'capacity': 150,
        'price': 25000,
        'image': '',
      });
      await batch.commit(noResult: true);
    }
  }

  Future<void> init() async {
    await db;
    await _seedIfEmpty();
  }

  Future<List<Map<String, dynamic>>> getBookings() async {
    final database = await db;
    final rows = await database.query('bookings', orderBy: 'date ASC');
    return rows;
  }

  Future<int> createBooking({
    required String user,
    required String event,
    required String date,
    String status = 'Pending',
  }) async {
    final database = await db;
    return database.insert('bookings', {
      'user': user,
      'event': event,
      'date': date,
      'status': status,
    });
  }

  Future<int> updateStatus({
    required int id,
    required String status,
  }) async {
    final database = await db;
    return database.update(
      'bookings',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Users
  Future<List<Map<String, dynamic>>> getUsers() async {
    final database = await db;
    return database.query('users', orderBy: 'id ASC');
  }

  Future<int> addUser({
    required String name,
    String? email,
    String? phone,
  }) async {
    final database = await db;
    return database.insert('users', {
      'name': name,
      'email': email,
      'phone': phone,
    });
  }

  Future<int> updateUser({
    required int id,
    String? name,
    String? email,
    String? phone,
  }) async {
    final database = await db;
    final data = <String, Object?>{};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    return database.update('users', data, where: 'id = ?', whereArgs: [id]);
  }

  // Venues
  Future<List<Map<String, dynamic>>> getVenues() async {
    final database = await db;
    return database.query('venues', orderBy: 'price ASC');
  }

  Future<int> addVenue({
    required String name,
    String? location,
    int? capacity,
    double? price,
    String? image,
  }) async {
    final database = await db;
    return database.insert('venues', {
      'name': name,
      'location': location,
      'capacity': capacity,
      'price': price,
      'image': image,
    });
  }

  // Favourites
  Future<List<Map<String, dynamic>>> getFavouritesForUser(int userId) async {
    final database = await db;
    return database.query('favourites', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<int> addFavourite({required int userId, required int venueId}) async {
    final database = await db;
    return database.insert('favourites', {
      'user_id': userId,
      'venue_id': venueId,
    });
  }

  Future<int> removeFavourite({required int userId, required int venueId}) async {
    final database = await db;
    return database.delete('favourites',
        where: 'user_id = ? AND venue_id = ?', whereArgs: [userId, venueId]);
  }

  // Payments
  Future<List<Map<String, dynamic>>> getPaymentsForBooking(int bookingId) async {
    final database = await db;
    return database.query('payments',
        where: 'booking_id = ?', whereArgs: [bookingId], orderBy: 'created_at DESC');
  }

  Future<int> addPayment({
    required int bookingId,
    required double amount,
    required String status,
    required String createdAt,
  }) async {
    final database = await db;
    return database.insert('payments', {
      'booking_id': bookingId,
      'amount': amount,
      'status': status,
      'created_at': createdAt,
    });
  }
}
