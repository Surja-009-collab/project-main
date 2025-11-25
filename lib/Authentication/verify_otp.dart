import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/services/forgot_password_service.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isOtpExpired = false;
  bool _canResend = false;
  int _secondsLeft = 120;
  Timer? _timer;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _isOtpExpired = false;
    _canResend = false;
    _secondsLeft = 120;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        }
        if (_secondsLeft == 0) {
          _isOtpExpired = true;
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  String get _otp => _otpControllers.map((c) => c.text.trim()).join();

  bool get _isOtpComplete =>
      _otpControllers.every((c) => c.text.trim().isNotEmpty);

  void _verifyOtp() {
    if (_isOtpComplete && !_isOtpExpired) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      final email = (args != null ? args['email'] : null) as String?;
      Navigator.pushReplacementNamed(
        context,
        '/reset_password',
        arguments: {
          'email': email,
          'otp': _otp,
        },
      );
    }
  }

  void _resendOtp() {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final email = (args != null ? args['email'] : null) as String?;
    if (email == null) return;
    ForgotPasswordService.instance.requestOtp(email).then((_) {
      for (final c in _otpControllers) {
        c.clear();
      }
      _startTimer();
      setState(() {
        _canResend = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('OTP resent')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to resend: $e')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Same as forgot password
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Image.asset('assets/images/logo.jpeg', width: 100, height: 100),
              const SizedBox(height: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Sans',
                  ),
                  children: [
                    TextSpan(
                      text: 'E',
                      style: TextStyle(color: Color(0xFF23223A)),
                    ),
                    TextSpan(
                      text: 'v',
                      style: TextStyle(color: Color(0xFF1CCFCF)),
                    ),
                    TextSpan(
                      text: 'entify',
                      style: TextStyle(color: Color(0xFF23223A)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Verify OTP',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Enter the 6-digit OTP sent to your email',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (i) {
                        return SizedBox(
                          width: 40,
                          child: TextField(
                            controller: _otpControllers[i],
                            focusNode: _focusNodes[i],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              if (val.length == 1 && i < 5) {
                                _focusNodes[i + 1].requestFocus();
                              }
                              if (val.isEmpty && i > 0) {
                                _focusNodes[i - 1].requestFocus();
                              }
                              setState(() {});
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 18),
                    if (_isOtpExpired)
                      const Text(
                        'OTP has expired.',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    else
                      Text(
                        'Resend OTP in ${_secondsLeft ~/ 60}:${(_secondsLeft % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: _GradientButton(
                        onPressed: _isOtpComplete && !_isOtpExpired
                            ? _verifyOtp
                            : null,
                        child: const Text('Verify OTP'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _canResend ? _resendOtp : null,
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          color: _canResend
                              ? const Color(0xFF8F5CFF)
                              : Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Color(0xFFE573B7),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF8F5CFF),
        unselectedItemColor: const Color.fromARGB(255, 73, 73, 73),
        onTap: (index) {
          setState(() => _currentIndex = index);
          // Simple navigation example:
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/search');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/booking');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/favourites');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
          // Add more routes as needed
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Bookings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Reuse the _GradientButton from login/forgot_password
class _GradientButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const _GradientButton({required this.onPressed, required this.child});

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Color(0xFF8F5CFF), Color.fromARGB(182, 127, 34, 225)],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: _isHovering ? null : gradient,
          color: _isHovering ? Colors.white : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            foregroundColor:
                _isHovering ? const Color(0xFF08182B) : Colors.white,
          ),
          onPressed: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}
