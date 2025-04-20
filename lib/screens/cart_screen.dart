import 'package:chair_shopping/constant/app_colors.dart';
import 'package:chair_shopping/controller/cart_controller.dart';
import 'package:chair_shopping/model/product_detail.dart' show ProductDetail;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Consumer, HookConsumerWidget, WidgetRef;

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productList = useRef([
      ProductDetail(
        id: 1,
        title: "Minimalist Chair",
        description: "Elegant and simple chair for any modern space.",
        image: "assets/images/chair.jpeg",
        price: 235.00,
        quantity: 1,
      ),
      ProductDetail(
        id: 2,
        title: "Wooden Desk",
        description: "A sleek wooden desk for your home office.",
        image: "assets/images/chair2.jpeg",
        price: 420.00,
        quantity: 1,
      ),
      ProductDetail(
        id: 3,
        title: "Modern Lamp",
        description: "Brighten up your room with this stylish lamp.",
        image: "assets/images/chair3.jpeg",
        price: 120.50,
        quantity: 1,
      ),
      ProductDetail(
        id: 4,
        title: "Comfy Sofa",
        description: "Relax in comfort with this cozy two-seater sofa.",
        image: "assets/images/chair4.jpeg",
        price: 680.00,
        quantity: 1,
      ),
      ProductDetail(
        id: 5,
        title: "Bookshelf Rack",
        description: "A tall, sturdy bookshelf for your favorite reads.",
        image: "assets/images/image5.jpg",
        price: 310.75,
        quantity: 1,
      ),
    ]);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 8),
        automaticallyImplyLeading: true,
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productList.value.length,
              itemBuilder: (context, index) {
                final product = productList.value[index];
                return CartCardView(productDetail: product);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: -5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
          border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Selected Items",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Consumer(
                  builder: (
                    BuildContext context,
                    WidgetRef ref,
                    Widget? child,
                  ) {
                    final selectedProductsTotal = ref.watch(
                      cartProvider.select((value) => value.selectedItemPrice),
                    );
                    return Text(
                      "\$ ${selectedProductsTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Shipping Fee",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Consumer(
                  builder: (
                    BuildContext context,
                    WidgetRef ref,
                    Widget? child,
                  ) {
                    final shippingCharge = ref.watch(
                      cartProvider.select((value) => value.shippingCharge),
                    );
                    return Text(
                      "\$ ${shippingCharge.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
            Divider(height: 30),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Consumer(
                  builder: (
                    BuildContext context,
                    WidgetRef ref,
                    Widget? child,
                  ) {
                    final subTotal = ref.watch(
                      cartProvider.select((value) => value.subTotal),
                    );
                    return Text(
                      "\$ ${subTotal..toStringAsFixed(2)}",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(size.width * 0.7, 60),
              ),
              onPressed: () {},
              child: Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Cart Card View
class CartCardView extends HookConsumerWidget {
  const CartCardView({required this.productDetail, super.key});

  final ProductDetail productDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantityNotifier = useValueNotifier<int>(1);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        spacing: 8,
        children: [
          InkWell(
            onTap: () {
              final selectedProducts = ref.read(cartProvider).selectedItem;
              if (selectedProducts.contains(productDetail)) {
                ref.read(cartProvider.notifier).removeFromCart(productDetail);
              } else {
                ref.read(cartProvider.notifier).addToCart(productDetail);
              }
              ref.read(cartProvider.notifier).calculatePrice();
            },
            child: Consumer(
              builder: (context, ref, child) {
                final selectedProducts = ref.watch(
                  cartProvider.select((value) => value.selectedItem),
                );
                final isSelected = selectedProducts.contains(productDetail);
                if (isSelected) {
                  return SvgPicture.asset(
                    "assets/icons/check.svg",
                    height: 24,
                    width: 24,
                  );
                } else {
                  return SvgPicture.asset(
                    "assets/icons/squre_check.svg",
                    height: 24,
                    width: 24,
                  );
                }
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              productDetail.image,
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productDetail.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ ${productDetail.price}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffDDDDE8)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        spacing: 4,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () {
                              quantityNotifier.value++;
                              productDetail.quantity = quantityNotifier.value;
                              ref.read(cartProvider.notifier).calculatePrice();
                            },
                            icon: Icon(Icons.add),
                          ),

                          HookBuilder(
                            builder: (context) {
                              final quantity = useValueListenable(
                                quantityNotifier,
                              );
                              return Text(
                                "$quantity",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                              );
                            },
                          ),

                          IconButton(
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () {
                              if (quantityNotifier.value > 1) {
                                quantityNotifier.value--;
                                productDetail.quantity = quantityNotifier.value;
                                ref
                                    .read(cartProvider.notifier)
                                    .calculatePrice();
                              }
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
