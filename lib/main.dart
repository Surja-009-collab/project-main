import 'package:flutter/material.dart';
import 'package:project/Admin/admin_home.dart';
import 'package:project/Authentication/admin_login.dart';
import 'package:project/Authentication/auth_state.dart';
import 'package:project/Authentication/forgot_password.dart';
import 'package:project/Authentication/login.dart';
import 'package:project/Authentication/privacy_security.dart';
import 'package:project/Authentication/reset_password.dart';
import 'package:project/Authentication/signup.dart' show RegisterPage;
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

// import 'package:project/screens/venue_details.dart';

void main() {
  runApp(const MyApp());
}

// Simple route guard widget
class RequireAuth extends StatelessWidget {
  final Widget child;
  const RequireAuth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthState.isLoggedIn,
      builder: (context, loggedIn, _) {
        if (loggedIn) return child;
        // Schedule navigation to login to avoid calling Navigator during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ModalRoute.of(context)?.isCurrent ?? true) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
        '/reset_password': (context) => const ResetPasswordPage(),
        '/drawer': (context) => const AppDrawer(),
        '/welcome': (context) => const WelcomePage(),
        '/venue': (context) => const VenuePage(),
        '/event_planner': (context) => const EventPlannerPage(),
        '/contact_us': (context) => const ContactUsPage(),
        '/about_us': (context) => const AboutUsPage(),
        '/favourites': (context) => RequireAuth(child: const FavouritesPage()),
        '/profile': (context) => RequireAuth(child: const ProfilePages()),
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
