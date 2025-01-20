import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/providers/paymentProvider.dart';
import 'package:possystem/utils/appColors.dart';

class CashSection extends ConsumerStatefulWidget {
  @override
  _CashSectionState createState() => _CashSectionState();
}

class _CashSectionState extends ConsumerState<CashSection> {
  bool isDot = false;
  bool isDone = false;

  // bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          !isDone
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 60,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: AppColors.secondary,
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Cash",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'RM${ref.watch(cashProvider).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              : SizedBox.shrink(),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 60,
            child: Card(
              color: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'RM${ref.watch(paymentChangeProvider).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          !isDone
              ? SizedBox(
                  height: 10,
                )
              : SizedBox(
                  height: 70,
                ),

          // First row: 1,2,3r
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...[1, 2, 3].map((digit) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: _buildKeypadButtonInt(digit),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: _buildKeypadButtonPlus(10),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...[4, 5, 6].map((digit) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: _buildKeypadButtonInt(digit),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: _buildKeypadButtonPlus(20),
              ),
            ],
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...[7, 8, 9].map((digit) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: _buildKeypadButtonInt(digit),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: _buildKeypadButtonPlus(30),
              ),
            ],
          ),
          SizedBox(height: 10),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                width: 140,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDot ? Color(0xFFFF6C0E) : Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    if (!isDone) {
                      setState(() {
                        isDot = !isDot;
                      });
                    }
                  },
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 16,
                        color: isDot ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: _buildKeypadButtonInt(0),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: 140,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF04438),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: _onBackspaceButtonPressed,
                    child: Center(
                      child: Icon(
                        Icons.backspace_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: 140,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      if (!isDone) {
                        if (ref.watch(paymentChangeProvider) >= 0.0) {
                          setState(() {
                            isDone = !isDone;
                          });
                        }
                      } else {
                        context.go(
                            '/menu/productpicker/process/membership/confirmationCart/processCash/processSuccessful');
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
          ]),
        ],
      ),
    );
  }

  void _onBackspaceButtonPressed() {
    if (!isDone) {
      // Fetch current value from cashProvider
      String currentValue = ref.watch(cashProvider).toString();
      double convertRM = 0.0;

      // Convert to double and handle backspace logic
      if (currentValue != '0.0') {
        String convertHundred =
            (double.parse(currentValue) * 100).toInt().toString();

        // Handle decimals
        String removeHundred =
            convertHundred.substring(0, convertHundred.length - 1);

        if (removeHundred.isNotEmpty) {
          convertRM = double.parse(removeHundred) / 100;
        }

        // Update the cashProvider with the new value
        ref.read(cashProvider.notifier).state = convertRM;

        // Update the paymentChangeProvider
        // ref.read(paymentChangeProvider.notifier).state =
        //     ref.watch(cashProvider) - ref.watch(cartTotalProvider);
      }
    }
  }

  void _onButtonPressed(bool isPlus, int value) {
    if (!isDone) {
      if (ref.watch(cashProvider) == 0.0 && value == 0) {
        return;
      }

      if (isPlus) {
        // Ensure current value is a double and correctly format it to two decimal places
        double currentValue = ref.watch(cashProvider);
        double newValue = currentValue + value;

        // Format the value to ensure it has 2 decimal places
        ref.read(cashProvider.notifier).state =
            double.parse(newValue.toStringAsFixed(2));

        // Update Changes
        // ref.read(paymentChangeProvider.notifier).state =
        //     ref.watch(cashProvider) - ref.watch(cartTotalProvider);
      } else {
        // Integer Function
        double currentValue = ref.watch(cashProvider);
        int currentValueInt = ref.watch(cashProvider).toInt();
        double valueDecimal = currentValue - currentValueInt;
        valueDecimal = double.parse(valueDecimal.toStringAsFixed(2));
        double newValue = 0.0;

        if (!isDot) {
          // Update only the whole numbers only
          newValue = (currentValueInt * 10).toDouble() + value + valueDecimal;
        } else {
          // Update the decimals only
          valueDecimal = (valueDecimal * 10) + value / 100;
          int wholeNumberRemover = valueDecimal.toInt();
          valueDecimal = valueDecimal - wholeNumberRemover;
          newValue = currentValueInt + valueDecimal;
        }

        // Format the value to ensure it has 2 decimal places
        ref.read(cashProvider.notifier).state =
            double.parse(newValue.toStringAsFixed(2));

        // Update Changes
        // ref.read(paymentChangeProvider.notifier).state =
        //     ref.watch(cashProvider) - ref.watch(cartTotalProvider);
      }
    }
  }

  Widget _buildKeypadButtonInt(
      // String digit, TextEditingController pinController, WidgetRef ref) {
      int digit) {
    return SizedBox(
      width: 140,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {
          // final currentPin = ref.read(pinProvider);
          // if (currentPin.length < 6) {
          //   ref.read(pinProvider.notifier).state = currentPin + digit;
          //   ref.read(loginErrorProvider.notifier).state = "";
          // }
          _onButtonPressed(false, digit);
        },
        child: Text(
          digit.toString(),
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildKeypadButtonPlus(
      // String digit, TextEditingController pinController, WidgetRef ref) {
      int number) {
    return SizedBox(
      width: 140,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF16B364),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {
          // final currentPin = ref.read(pinProvider);
          // if (currentPin.length < 6) {
          //   ref.read(pinProvider.notifier).state = currentPin + digit;
          //   ref.read(loginErrorProvider.notifier).state = "";
          // }
          _onButtonPressed(true, number);
        },
        child: Text(
          '+${number.toString()}',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
