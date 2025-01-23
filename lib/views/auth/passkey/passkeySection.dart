import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:possystem/app/app.dart';
import 'package:possystem/providers/loginProvider.dart';
import 'package:possystem/utils/appHelper.dart';

class PasskeySection extends ConsumerWidget {
  const PasskeySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinController = TextEditingController();
    final errorMessage = ref.watch(loginErrorProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top Login
          Center(
            child: SvgPicture.asset('assets/svg/login/person_pin.svg',
                width: 80, height: 80),
          ),
          SizedBox(height: 10),
          Text("Employee Login",
              style: AppTexts.medium(size: 20, color: AppColors.secondary)),
          SizedBox(height: 15),
          Text("Choose your account to start your shift",
              style: AppTexts.regular(size: 18, color: Colors.white)),
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.36,
            color: AppColors.orangeDark50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/person.png'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Izzat Hidir",
                            style:
                                AppTexts.medium(size: 18, color: Colors.black)),
                        Text("12:00 PM - 10:00 PM",
                            style: AppTexts.medium(
                                size: 18, color: AppColors.secondary)),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.arrow_drop_down_outlined,
                    size: 32, color: Colors.black),
              ],
            ),
          ),
          SizedBox(height: 20),
          // PIN display circles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              final pin = ref.watch(pinProvider);
              bool isFilled = pin.length > index;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.greyText,
                  ),
                  color: isFilled
                      ? AppColors.secondary
                      : const Color.fromRGBO(0, 0, 0, 0),
                ),
              );
            }),
          ),
          SizedBox(height: 32),
          // Keypad
          Column(
            children: [
              // First row: 1,2,3
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1, 2, 3]
                    .map((digit) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _buildKeypadButton(
                              digit.toString(), pinController, ref),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20), // Space between rows

              // Second row: 4,5,6
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [4, 5, 6]
                    .map((digit) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _buildKeypadButton(
                              digit.toString(), pinController, ref),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20), // Space between rows

              // Third row: 7,8,9
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [7, 8, 9]
                    .map((digit) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _buildKeypadButton(
                              digit.toString(), pinController, ref),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20), // Space between rows

              // Fourth row: Clear, 0, Backspace
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.loginKeypad,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          ref.read(pinProvider.notifier).state = '';
                          ref.read(loginErrorProvider.notifier).state = "";
                        },
                        child: Text("X",
                            style:
                                TextStyle(fontSize: 36, color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: _buildKeypadButton('0', pinController, ref),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.loginKeypad,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          final currentPin = ref.read(pinProvider);
                          if (currentPin.isNotEmpty) {
                            ref.read(pinProvider.notifier).state =
                                currentPin.substring(0, currentPin.length - 1);
                          }
                          ref.read(loginErrorProvider.notifier).state = "";
                        },
                        child: Center(
                          child: Icon(
                            Icons.backspace,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              minimumSize: Size(350, 50),
            ),
            onPressed: () {
              //Validation
              final pin = ref.read(pinProvider);
              if (pin.length == 6) {
                if (pin == "000000") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AppPage()),
                  );
                } else {
                  ref.read(loginErrorProvider.notifier).state =
                      "Invalid PIN. Try again";
                }
              } else {
                ref.read(loginErrorProvider.notifier).state =
                    "PIN must be 6 digits";
              }
            },
            child: Text("Sign In",
                style: AppTexts.medium(size: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

Widget _buildKeypadButton(
    String digit, TextEditingController pinController, WidgetRef ref) {
  return SizedBox(
    width: 70,
    height: 70,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.loginKeypad,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      onPressed: () {
        final currentPin = ref.read(pinProvider);
        if (currentPin.length < 6) {
          ref.read(pinProvider.notifier).state = currentPin + digit;
          ref.read(loginErrorProvider.notifier).state = "";
        }
      },
      child: Text(
        digit,
        style: TextStyle(fontSize: 36, color: Colors.white),
      ),
    ),
  );
}
