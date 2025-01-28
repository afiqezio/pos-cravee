import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:possystem/app/app.dart';
import 'package:possystem/features/auth/login/viewmodels/authViewmodel.dart';
import 'package:possystem/features/auth/login/views/widgets/snackbar.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/widgets/customButton.dart';
import 'package:possystem/widgets/customLoading.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.canvasPrimary,
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
                    style: AppTexts.semiBold(
                        size: 24, color: AppColors.primaryText)),
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
              authState.when(
                data: (user) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.26),
                    child: CustomActionButton(
                      label: 'Login',
                      textStyle: AppTexts.medium(
                          size: 16, color: AppColors.secondaryText),
                      onTap: () async {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          showSnackBar(context,
                              'Please fill in both email and password.');
                          return;
                        }

                        final success = await ref
                            .read(authViewModelProvider.notifier)
                            .login(email, password, ref);

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AppPage()),
                          );
                        } else {
                          showSnackBar(
                              context, 'Login failed. Please try again.');
                        }
                      },
                    ),
                  );
                },
                error: (error, stackTrace) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3),
                  child: CustomActionButton(
                    label: 'Retry',
                    textStyle: AppTexts.medium(
                        size: 16, color: AppColors.secondaryText),
                    backgroundColor: AppColors.secondary,
                    onTap: () {
                      ref.read(authViewModelProvider.notifier).logout(ref);
                    },
                  ),
                ),
                loading: () => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.38, vertical: 12),
                  child: CustomLoading(size: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
