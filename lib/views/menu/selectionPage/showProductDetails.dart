import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/providers/cartProvider.dart';
import 'package:possystem/models/addOn.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/utils/widget/customCircle.dart';
import '../../../models/product.dart';

void showProductDetails(BuildContext context, WidgetRef ref, Product product) {
  String? note = '';
  int quantity = 1;
  List<AddOn> selectedAddOns = [];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          // Blurry Background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          // Centered Details
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, size: 22),
                      color: Colors.black,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 6,
                      children: [
                        // Left Side
                        Expanded(
                          child: Column(
                            spacing: 6,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Product Image
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF4ED),
                                  image: DecorationImage(
                                    image: AssetImage(product.imageUrl),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Product Name and Price
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.name,
                                      style: AppTexts.medium(size: 18),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'RM ${product.price.toStringAsFixed(2)}',
                                    style: AppTexts.medium(
                                        size: 18, color: AppColors.secondary),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Quantity Controls
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: AppColors.secondary,
                                            width: 1,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                quantity--;
                                              });
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '$quantity',
                                        style: AppTexts.regular(size: 18),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: AppColors.secondary,
                                            width: 1,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              quantity++;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Side
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // AddOn List
                              Text(
                                'Add on',
                                style: AppTexts.medium(size: 18),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 164,
                                child: ListView.builder(
                                  itemCount: addOn.length,
                                  itemBuilder: (context, index) {
                                    final addOnItem = addOn[index];
                                    bool isChecked = false;

                                    return Column(
                                      children: [
                                        StatefulBuilder(
                                          builder: (context, setState) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomCircle(
                                                    size: 18,
                                                    borderColor: selectedAddOns
                                                            .contains(addOnItem)
                                                        ? AppColors.secondary
                                                        : AppColors.greyText,
                                                    borderThickness: 1.5,
                                                    fillColor: isChecked
                                                        ? AppColors.secondary
                                                        : Colors.white,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isChecked = !isChecked;
                                                        if (isChecked) {
                                                          selectedAddOns
                                                              .add(addOnItem);
                                                        } else {
                                                          selectedAddOns.remove(
                                                              addOnItem);
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  addOnItem.name,
                                                  style: AppTexts.regular(
                                                      size: 18),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        const Divider(
                                            thickness: 0.3, height: 10),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Notes Section
                              Text(
                                'Notes',
                                style: AppTexts.medium(size: 18),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Write a message',
                                  labelStyle: AppTexts.regular(
                                      size: 18, color: AppColors.greyText),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.secondary,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  note = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Add to Cart Button
                    ElevatedButton(
                      onPressed: () {
                        addProduct(
                            ref, product, quantity, selectedAddOns, note);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: AppTexts.regular(size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
