import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/views/auth/passkey/passkeyMain.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset('assets/svg/cravee/cravee_logo.svg',
                  width: 80, height: 80),
              Center(
                child: Text('Cravee POS',
                    style: AppTexts.semiBold(size: 24, color: Colors.black)),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.26),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    // Handle login logic here
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    debugPrint('Email: $email, Password: $password');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasskeyPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Login',
                      style: AppTexts.medium(size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 16),
              // TextButton(
              //   onPressed: () {
              //     // Handle forgot password
              //     debugPrint('Forgot Password pressed');
              //   },
              //   child: const Text('Forgot Password?'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
