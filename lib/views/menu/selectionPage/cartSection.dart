import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/utils/widget/customSlider.dart';
import 'package:possystem/views/menu/selectionPage/showCartDetails.dart';
import 'package:possystem/views/menu/selectionPage/showPaymentMethod.dart';
import '../../../providers/cartProvider.dart';

class CartSection extends ConsumerStatefulWidget {
  final bool isConfirmation;
  const CartSection({super.key, required this.isConfirmation});

  @override
  ConsumerState<CartSection> createState() => _CartSectionState();
}

class _CartSectionState extends ConsumerState<CartSection>
    with SingleTickerProviderStateMixin {
  late bool _isConfirmation;
  bool _isMenuPressed = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _isConfirmation = widget.isConfirmation;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen to the right
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuPressed = !_isMenuPressed;
      if (_isMenuPressed) {
        _controller.forward(); // Slide in
      } else {
        _controller.reverse(); // Slide out
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/menu/cart.svg',
                          fit: BoxFit.fitWidth,
                          color: Colors.black,
                          width: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Cart',
                          style: AppTexts.medium(size: 16),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: _toggleMenu,
                      child: Container(
                        // color: Colors.red,
                        padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
                        child: SvgPicture.asset(
                          'assets/svg/menu/menu.svg',
                          fit: BoxFit.fitWidth,
                          color: Colors.black,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                )),
            const Divider(thickness: 0.9, height: 0.5),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: !_isMenuPressed
                    ? _cartValidation(context, ref)
                    : SlideTransition(
                        position: _slideAnimation,
                        child: _cartUtilities(context, ref),
                      ),
              ),
            ),
            // Display totals
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Total Sales',
                          style: AppTexts.medium(size: 18),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'RM ${(ref.watch(cartSalesProvider).totalSales).toStringAsFixed(2)}',
                          style: AppTexts.regular(size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount',
                          style: AppTexts.medium(
                              size: 18, color: AppColors.greyText)),
                      Text(
                          '-RM${ref.watch(cartSalesProvider).discount.toStringAsFixed(2)}',
                          style: AppTexts.regular(size: 18)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Voucher',
                          style: AppTexts.medium(
                              size: 18, color: AppColors.greyText)),
                      Text(
                          '-RM${ref.watch(cartSalesProvider).voucher.toStringAsFixed(2)}',
                          style: AppTexts.regular(size: 18)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax 7%',
                          style: AppTexts.medium(
                              size: 18, color: AppColors.greyText)),
                      Text(
                          'RM ${(ref.watch(cartSalesProvider).tax).toStringAsFixed(2)}',
                          style: AppTexts.regular(size: 18)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: AppTexts.medium(size: 18)),
                      Text(
                          'RM ${(ref.watch(cartSalesProvider).subtotal).toStringAsFixed(2)}',
                          style: AppTexts.regular(size: 18)),
                    ],
                  ),
                  const Divider(thickness: 0.9),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTexts.medium(size: 18)),
                      Text(
                          'RM ${(ref.watch(cartSalesProvider).subtotal).toStringAsFixed(2)}',
                          style: AppTexts.medium(
                              size: 18, color: AppColors.secondary)),
                    ],
                  ),
                ],
              ),
            ),
            // Clear Basket Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => clearCart(ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: Text(
                        'Clear Basket',
                        style: AppTexts.regular(size: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: cart.isEmpty
                          ? null
                          : () {
                              if (!_isConfirmation) {
                                context.go('/menu/productpicker/process');
                              } else {
                                showPaymentMethod(context, ref);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cart.isEmpty
                            ? Color(0xFFB8C1CC)
                            : AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: Text(
                        'Pay',
                        style: AppTexts.regular(size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget build

Widget _cartUtilities(BuildContext context, WidgetRef ref) {
  // final cart = ref.watch(cartProvider);
  return Column(
    children: [
      Container(
        color: AppColors.violet100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long_outlined, color: Colors.black, size: 20),
              const SizedBox(width: 10),
              Text('Bill', style: AppTexts.regular(size: 16)),
            ],
          ),
        ),
      ),
      Container(
        color: AppColors.orangeDark100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.price_change_outlined, color: Colors.black, size: 20),
              const SizedBox(width: 10),
              Text('Pricelist', style: AppTexts.regular(size: 16)),
            ],
          ),
        ),
      ),
      Container(
        color: AppColors.indigo100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_money_outlined, color: Colors.black, size: 20),
              const SizedBox(width: 10),
              Text('Tax', style: AppTexts.regular(size: 16)),
            ],
          ),
        ),
      ),
      Container(
        color: AppColors.error100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.clear_outlined, color: Colors.black, size: 20),
              const SizedBox(width: 10),
              Text('Clear Order', style: AppTexts.regular(size: 16)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _cartValidation(BuildContext context, WidgetRef ref) {
  final cart = ref.watch(cartProvider);
  return cart.isNotEmpty
      ? _buildCartItem(context, ref)
      : Center(
          child: Text(
            'No Item Selected',
            style: AppTexts.regular(size: 16, color: AppColors.greyDark),
          ),
        );
}

Widget _buildCartItem(BuildContext context, WidgetRef ref) {
  final cart = ref.watch(cartProvider);
  return ListView.builder(
    itemCount: cart.length,
    itemBuilder: (context, index) {
      final entry = cart.entries.toList()[index];
      final product = entry.key;
      final cartItem = entry.value;
      return ClipRect(
        child: Slidable(
          key: Key(product.id.toString()),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              CustomSlidable(
                onPressed: (context) {
                  showCartDetails(context, ref, product, cartItem);
                },
                backgroundColor: Color(0xFFEAECF5),
                foregroundColor: Colors.black,
                icon: Icons.edit_outlined,
              ),
              CustomSlidable(
                onPressed: (context) {
                  clearProduct(ref, product);
                },
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete_outlined,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.only(right: 12.0, top: 14.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(product.imageUrl),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Product Details
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: AppTexts.regular(size: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            cartItem.addOns != null &&
                                    cartItem.addOns!.isNotEmpty
                                ? cartItem.addOns!
                                    .map((addOn) => addOn.name)
                                    .join(', ')
                                : 'No Add-Ons',
                            style: AppTexts.regular(
                              size: 16,
                              color: AppColors.greyText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Minus Button
                              TextButton(
                                onPressed: () => removeProduct(ref, product, 1),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFF3F3F9),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8.0),
                                  minimumSize: const Size(30, 40),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '-',
                                    style: AppTexts.regular(size: 16),
                                  ),
                                ),
                              ),
                              // Quantity Display
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '${cartItem.quantity}',
                                    style: AppTexts.regular(size: 16),
                                  ),
                                ),
                              ),
                              // Plus Button
                              TextButton(
                                onPressed: () =>
                                    addProduct(ref, product, 1, null, null),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFF3F3F9),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8.0),
                                  minimumSize: const Size(30, 40),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '+',
                                    style: AppTexts.regular(size: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    // Product Price
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AutoSizeText(
                            'RM${(product.price * cartItem.quantity).toStringAsFixed(2)}',
                            maxLines: 1,
                            style: AppTexts.medium(
                                size: 16, color: AppColors.secondary),
                          ),
                          // Calculate tax
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AutoSizeText(
                                maxLines: 1,
                                '+',
                                style: AppTexts.regular(
                                    size: 16, color: AppColors.greyText),
                              ),
                              AutoSizeText(
                                maxLines: 1,
                                'RM${((product.price * cartItem.quantity) * 0.07).toStringAsFixed(2)}',
                                style: AppTexts.regular(
                                    size: 16, color: AppColors.greyText),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.4,
                height: 0,
              ),
            ],
          ),
        ),
      );
    },
  );
}
