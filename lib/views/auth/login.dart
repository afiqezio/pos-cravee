import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:possystem/app/app.dart';
import 'package:possystem/providers/loginProvider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    // Clear PIN when page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pinProvider.notifier).state = '';
      ref.read(loginErrorProvider.notifier).state = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final errorMessage = ref.watch(loginErrorProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Left half - Image with SVG overlay
          Expanded(
            child: Stack(
              children: [
                // Background Image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login/login-1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // SVG Overlay 1
                Positioned(
                  top: 30,
                  left: 10,
                  child: SvgPicture.asset(
                    'assets/svg/login/watermark.svg',
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width * 0.2,
                    fit: BoxFit.contain,
                  ),
                ),
                // SVG Overlay 2
                Positioned(
                  bottom: 150,
                  left: 50,
                  child: SvgPicture.asset(
                    'assets/svg/login/comma.svg',
                    alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width * 0.04,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text Overlay
                // Positioned(
                //   bottom: 10,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 32.0),
                //     child: Text(
                //         'Pretzley brings a range of exciting and bold flavors, pushing the boundaries of traditional pretzel-making to cater to diverse taste preferences.',
                //         style: TextStyle(
                //             fontSize: 18,
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold)),
                //   ),
                // ),
              ],
            ),
          ),
          // Right half - PIN input
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Login
                  Center(
                    child: SvgPicture.asset('assets/svg/login/person_pin.svg',
                        width: 100, height: 100),
                  ),
                  SizedBox(height: 20),
                  Text("Employee Login",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFF6C0E),
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text("Choose your account to start your shift",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
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
                              color: const Color.fromARGB(128, 142, 142, 142)),
                          color: isFilled
                              ? Color(0xFFFF6C0E)
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
                                  backgroundColor:
                                      Color.fromARGB(128, 142, 142, 142),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                ),
                                onPressed: () {
                                  ref.read(pinProvider.notifier).state = '';
                                  ref.read(loginErrorProvider.notifier).state =
                                      "";
                                },
                                child: Text("X",
                                    style: TextStyle(
                                        fontSize: 36, color: Colors.white)),
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
                                  backgroundColor:
                                      Color.fromARGB(128, 142, 142, 142),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                ),
                                onPressed: () {
                                  final currentPin = ref.read(pinProvider);
                                  if (currentPin.isNotEmpty) {
                                    ref.read(pinProvider.notifier).state =
                                        currentPin.substring(
                                            0, currentPin.length - 1);
                                  }
                                  ref.read(loginErrorProvider.notifier).state =
                                      "";
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
                      backgroundColor: Color(0xFFFF6C0E),
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
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SidebarPage()),
                          // );
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
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(
      String digit, TextEditingController pinController, WidgetRef ref) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(128, 142, 142, 142),
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
}
