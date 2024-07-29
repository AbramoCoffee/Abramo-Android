import 'package:abramo_coffee/models/cart_model.dart';
import 'package:abramo_coffee/providers/cart_provider.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<CartModel> cartItems = <CartModel>[].obs;
  RxDouble subtotal = 0.0.obs;
  RxDouble total = 0.0.obs;
  // RxInt tax = 0.obs;

  Future addToCart(CartModel cartModel) async {
    try {
      await CartProvider.instance.insert(cartModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getCartItems() async {
    try {
      isLoading.value = true;
      final datas = await CartProvider.instance.query();
      cartItems.value = datas;
      if (datas.isNotEmpty) {
        getItemSubtotal();
      }
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  void setSubtotalDefault() {
    subtotal.value = 0;
  }

  Future getItemSubtotal() async {
    try {
      final subtotal = await CartProvider.instance.getItemSubtotal();
      this.subtotal.value = subtotal;
      // tax.value = (subtotal * 10 / 100).round();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateCartItem(CartModel cartModel) async {
    try {
      await CartProvider.instance.update(cartModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future increaseQuantity(CartModel item) async {
    CartModel cartModel = CartModel(
      id: item.id,
      name: item.name,
      price: item.price,
      quantity: item.quantity! + 1,
      image: item.image,
      subTotalPerItem: item.subTotalPerItem! + item.price!,
    );
    try {
      await CartProvider.instance
          .update(cartModel)
          .then((value) => getCartItems().then((value) => getItemSubtotal()));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future decreaseQuantity(CartModel item) async {
    CartModel cartModel = CartModel(
      id: item.id,
      name: item.name,
      price: item.price,
      quantity: item.quantity! - 1,
      image: item.image,
      subTotalPerItem: item.subTotalPerItem! - item.price!,
    );
    try {
      await CartProvider.instance.update(cartModel).then((value) {
        if (cartItems.isNotEmpty) {
          getCartItems().then((value) => getItemSubtotal());
        }
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future deleteCartItem(int id) async {
    try {
      await CartProvider.instance.delete(id).then((value) {
        if (cartItems.isNotEmpty) {
          getCartItems().then((value) => subtotal.value = 0);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future deleteAllData() async {
    try {
      await CartProvider.instance.deleteAllData().then((value) {
        if (cartItems.isNotEmpty) {
          getCartItems().then((value) => getItemSubtotal());
        }
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
