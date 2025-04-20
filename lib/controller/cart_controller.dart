import 'package:chair_shopping/model/product_detail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show StateNotifier, StateNotifierProvider;

final cartProvider = StateNotifierProvider.autoDispose<CartController,CartState>((ref) => CartController());

class CartController extends StateNotifier<CartState> {
  CartController() : super(CartState.initial());

  /// Add To Cart
  void addToCart(ProductDetail productDetail){
    state = state.copyWith(selectedItem: [...state.selectedItem, productDetail]);
  }

  /// Remove From Cart
  void removeFromCart(ProductDetail productDetail){
    state = state.copyWith(selectedItem: state.selectedItem.where((element) => element.id != productDetail.id).toList());
  }

  /// Calculate Price
  void calculatePrice(){
    double selectedItemPrice = 0.0;
    double subTotal = 0.0;
    double shippingCharge = 0.0;
    for (var element in state.selectedItem) {
      selectedItemPrice += element.price * element.quantity;
      shippingCharge += element.price * element.quantity * 0.05;
      subTotal += element.price * element.quantity;
    }
    state = state.copyWith(
        selectedItemPrice: selectedItemPrice,
        subTotal: subTotal + shippingCharge,
        shippingCharge: shippingCharge);
  }

}


/// Cart State
class CartState{
  List<ProductDetail> selectedItem;
  double selectedItemPrice;
  double shippingCharge;
  double subTotal;

  CartState({
    required this.selectedItem,
    required this.selectedItemPrice,
    required this.shippingCharge,
    required this.subTotal});

  // ----------------------- Copy With ----------------------- //
  CartState copyWith({
    List<ProductDetail>? selectedItem,
    double? selectedItemPrice,
    double? shippingCharge,
    double? subTotal
  }){
    return CartState(
        selectedItem: selectedItem ?? this.selectedItem,
        selectedItemPrice: selectedItemPrice ?? this.selectedItemPrice,
        shippingCharge: shippingCharge ?? this.shippingCharge,
        subTotal: subTotal ?? this.subTotal);
  }

  // ----------------------- Initial State ----------------------- //
  factory CartState.initial(){
    return CartState(
        selectedItem: [],
        selectedItemPrice: 0.0,
        shippingCharge: 0.0,
        subTotal: 0.0
    );
  }
}