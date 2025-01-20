import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/providers/paymentProvider.dart';
import 'package:possystem/utils/appColors.dart';

class PhoneNumberSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<PhoneNumberSection> createState() => _PhoneNumberSectionState();
}

class _PhoneNumberSectionState extends ConsumerState<PhoneNumberSection> {
  final List<TextEditingController> _controllers =
      List.generate(11, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(11, (_) => FocusNode());
  bool _showError = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  bool _isPhoneNumberComplete() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: const Text(
              "Phone Number",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(12, (index) {
                if (index == 3) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      "-",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                int inputIndex = index > 3 ? index - 1 : index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[inputIndex],
                      focusNode: _focusNodes[inputIndex],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        counterText: "",
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        // errorText:
                        //     _showError && _controllers[inputIndex].text.isEmpty
                        //         ? "Required"
                        //         : null,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && inputIndex < 10) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[inputIndex + 1]);
                        } else if (value.isEmpty && inputIndex > 0) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[inputIndex - 1]);
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          if (_showError)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: Text(
                  "Oops! That phone number doesn’t seem right. Please double-check and try again.",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  ref.read(isPhoneFlagProvider.notifier).state = false;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: SvgPicture.asset(
                    'assets/svg/widget/back.svg',
                    width: 16,
                    height: 16,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showError = !_isPhoneNumberComplete();
                  });
                  if (_isPhoneNumberComplete()) {
                    context.go('/menu/productpicker/process/membership');
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 42),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: Card(
                      color: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
