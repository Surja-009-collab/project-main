import 'dart:io' show Platform;
import 'services/database_service.dart';
import 'package:firebase_core/firebase_core.dart';


import 'repositories/booking_repository.dart';  // Add this import
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:project/Admin/admin_home.dart';
import 'package:project/Authentication/admin_login.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/Authentication/forgot_password.dart';
import 'package:project/Authentication/login.dart';
import 'package:project/Authentication/privacy_security.dart';
import 'package:project/Authentication/reset_password.dart';
import 'package:project/Authentication/signup.dart' show RegisterPage;
import 'package:project/Authentication/verify_email.dart';
import 'package:project/Authentication/verify_otp.dart';
import 'package:project/screens/about_us_page.dart';
import 'package:project/screens/booking_screen.dart';
import 'package:project/screens/bookvenue.dart';
import 'package:project/screens/contact_us_page.dart';
import 'package:project/screens/drawer.dart';
import 'package:project/screens/event_planner_page.dart';
import 'package:project/screens/favourite_screen.dart';
import 'package:project/screens/help_support.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/logo.dart' show EventifyScreen;
import 'package:project/screens/payment/payments_screen.dart';
import 'package:project/screens/personal_info.dart';
import 'package:project/screens/profile_page.dart';
import 'package:project/screens/search_screen.dart';
import 'package:project/screens/venue_page.dart';
import 'package:project/screens/welcome_page.dart' show WelcomePage;
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'firebase_options.dart';
import 'repositories/venue_repository.dart';


// import 'package:project/screens/venue_details.dart';

class RequireAuth extends StatelessWidget {
  final Widget child;
  const RequireAuth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthState.isLoggedIn,
      builder: (context, isLoggedIn, _) {
        if (isLoggedIn) return child;
        
        // If not logged in, redirect to login
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ModalRoute.of(context)?.isCurrent ?? true) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
        
        // Show loading indicator while redirecting
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
} 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  } catch (_) {}

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>(create: (_) => DatabaseService()),
        Provider<VenueRepository>(create: (_) => VenueRepository()),
        Provider<BookingRepository>(create: (_) => BookingRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

// Admin-only route guard
class RequireAdmin extends StatelessWidget {
  final Widget child;
  const RequireAdmin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthState.isAdminLoggedIn,
      builder: (context, loggedIn, _) {
        if (loggedIn) return child;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ModalRoute.of(context)?.isCurrent ?? true) {
            Navigator.pushReplacementNamed(context, '/admin_login');
          }
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      // home: EventifyHome(),
      // Named routes for navigation
      routes: {
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/booking': (context) => RequireAuth(child: const BookingPage()),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const RegisterPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/verify_otp': (context) => const VerifyOtpPage(),
        '/verify_email': (context) => const VerifyEmailPage(),
        '/reset_password': (context) => const ResetPasswordPage(),
        '/drawer': (context) => const AppDrawer(),
        '/welcome': (context) => const WelcomePage(),
        '/venue': (context) => const VenuePage(),
        '/event_planner': (context) => const EventPlannerPage(),
        '/contact_us': (context) => const ContactUsPage(),
        '/about_us': (context) => const AboutUsPage(),
        '/favourites': (context) => RequireAuth(child: const FavouritesPage()),
        '/profile': (context) => RequireAuth(child: const ProfilePage()),
        '/bookvenue': (context) => RequireAuth(child: const VenueBookingPage()),
        '/personal_info': (context) => const PersonalInformationScreen(),
        '/privacy_security': (context) => const PrivacySecurityScreen(),
        '/payment_screen': (context) => const PaymentsScreen(),
        '/admin_login': (context) => const AdminLoginPage(),
        '/admin_home': (context) => RequireAdmin(child: const AdminHomePage()),
        '/help_support': (context) => const HelpSupportScreen(),
        // '/venue_details': (context) => const VenueDetailsPage(),
        // '/logo': (context) => const EventifyScreen(),
      },
      home: const SplashToWelcome(),
      // home: AdminHomePage(),
    );
  }
}

// Add this widget to handle splash -> welcome navigation
class SplashToWelcome extends StatefulWidget {
  const SplashToWelcome({super.key});

  @override
  State<SplashToWelcome> createState() => _SplashToWelcomeState();
}

class _SplashToWelcomeState extends State<SplashToWelcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const EventifyScreen(); // Show logo.dart splash screen
  }
}
