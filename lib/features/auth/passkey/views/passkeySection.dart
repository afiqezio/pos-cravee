import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:possystem/app/app.dart';
import 'package:possystem/features/auth/passkey/viewmodels/passkeyViewmodel.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/features/auth/passkey/views/widgets/loginDropdown.dart';
import 'package:possystem/widgets/custom/customLoading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasskeySection extends ConsumerStatefulWidget {
  const PasskeySection({Key? key}) : super(key: key);

  @override
  _PasskeySectionState createState() => _PasskeySectionState();
}

class _PasskeySectionState extends ConsumerState<PasskeySection> {
  final pinController = TextEditingController();
  List<Map<String, String>> userList = [];
  bool isLoading = false;

  Future<List<Map<String, String>>> getPreferencesUserList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userListString = prefs.getString('userList');

    if (userListString != null) {
      // Decode the JSON string back to a list of maps
      List<dynamic> userListJson = jsonDecode(userListString);
      return userListJson
          .map((user) => Map<String, String>.from(user))
          .toList();
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getPreferencesUserList().then((value) {
      setState(() {
        userList = value;
        // Assign the first item to the selectedDropdownValueProvider if userList is not empty
        if (userList.isNotEmpty) {
          ref.read(selectedDropdownValueProvider.notifier).state =
              DropdownModel(
            id: userList.first['id'] ?? '0',
            title:
                '${userList.first['firstName'] ?? ''} ${userList.first['lastName'] ?? ''}',
            description: '12:00 PM - 06:00 PM',
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              style: AppTexts.medium(size: 20, color: AppColors.secondary),
              textAlign: TextAlign.center),
          SizedBox(height: 15),
          Text("Choose your account to start your shift",
              style: AppTexts.medium(size: 18, color: AppColors.secondaryText),
              textAlign: TextAlign.center),
          SizedBox(height: 15),
          LoginDropdown(
            imagePath: 'assets/images/person.png',
            items: userList.isNotEmpty
                ? userList
                    .map((user) => DropdownModel(
                          id: user['id'] ?? '0',
                          // id: 1,
                          title:
                              '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}',
                          // description: user['gender'].toString(),
                          description: '12:00 PM - 06:00 PM',
                        ))
                    .toList()
                : [],
            onItemSelected: (value) {
              // debugPrint("value: $value");
            },
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
                      : AppColors.canvasSecondary,
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
                          child: buildKeypadButton(
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
                          child: buildKeypadButton(
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
                          child: buildKeypadButton(
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
                            style: TextStyle(
                                fontSize: 36,
                                color: ref.watch(pinProvider) == ''
                                    ? AppColors.greyText
                                    : AppColors.secondaryText)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: buildKeypadButton('0', pinController, ref),
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
                        child: Icon(
                          Icons.backspace_outlined,
                          size: 28,
                          color: ref.watch(pinProvider) == ''
                              ? AppColors.greyText
                              : AppColors.secondaryText,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              // Validation
              final pin = ref.read(pinProvider);
              const requiredPinLength = 6;
              if (validatePin(pin, requiredPinLength)) {
                try {
                  if (await loginByKey(pin, ref)) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AppPage()),
                    );
                  } else {
                    ref.read(loginErrorProvider.notifier).state =
                        "Invalid PIN. Try again";
                  }
                } catch (e) {
                  ref.read(loginErrorProvider.notifier).state =
                      "An error occurred. Please try again.";
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              } else {
                ref.read(loginErrorProvider.notifier).state =
                    "PIN must be $requiredPinLength digits";
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: isLoading
                ? CustomLoading(
                    color: AppColors.secondaryText,
                    size: 26,
                    strokeWidth: 5,
                  )
                : Text("Sign In",
                    style: AppTexts.medium(
                        size: 18, color: AppColors.secondaryText)),
          ),
        ],
      ),
    );
  }

  bool validatePin(String pin, int requiredLength) {
    return pin.length == requiredLength;
  }
}
