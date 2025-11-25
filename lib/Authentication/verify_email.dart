import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool _checking = false;

  Future<void> _resend() async {
    setState(() => _checking = true);
    try {
      await AuthService.instance.resendVerificationEmail();
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Verification email sent')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to send email: $e')));
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _iveVerified() async {
    setState(() => _checking = true);
    try {
      final ok = await AuthService.instance.refreshAndCheckVerified();
      if (!mounted) return;
      if (ok) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Email verified. Please sign in.')));
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Not verified yet. Check your inbox.')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Check failed: $e')));
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify your email')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We\'ve sent a verification link to your email. Open the link, then return here.',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checking ? null : _resend,
              child: const Text('Resend verification email'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _checking ? null : _iveVerified,
              child: const Text("I've verified"),
            ),
          ],
        ),
      ),
    );
  }
}
