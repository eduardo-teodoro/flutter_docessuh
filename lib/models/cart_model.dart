import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docessuh/datas/cart_product.dart';
import 'package:docessuh/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  //usuário atual
  UserModel user;

  //lista de produtos
  List<CartProduct> products = [];

  String cuponCode;
  int discountPercentage=0;

  bool isLoading = false;

  //construtor
  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadcartItems();
    }
  }

  //para conseguir acessar de todas as classes o Cart model
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  //função para adicionar um novo produto no carrinho
  void addCartItem(CartProduct cartProduct) {
    //adicionando ao carrinho
    products.add(cartProduct);
    //adicionando ao banco de dados dentro do firebase
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  //função para remover um novo produto no carrinho
  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();
    products.remove(cartProduct);

    notifyListeners();
  }
//decrementar a quantidade no pedido
  void decProduct(CartProduct cartProduct) {
    //atualizando quantidade
    cartProduct.quantity--;
    //atualizando no Firestore
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    //
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    //atualizando quantidade
    cartProduct.quantity++;
    //atualizando no Firestore
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    //
    notifyListeners();
  }

  //aplicando desconto do carrinho
  void setCoupon(String couponCode, int discountPercentage) {
    this.cuponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  //para atualizar os valores assim que a tela do carrinho for carregada
  void updatePrices() {
    notifyListeners();
  }

  //retorna o subtotal. calcula o total dos produtos
  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null)
        price += c.quantity * c.productData.price;
    }
    return price;
  }

//retorna o desconto
  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

//retorna o valor da entrega
  double getShipPrice() {
    return 9.99;
  }

  Future<String> finishOrder() async {
    //verificando se a lista de produtos está vazia
    if (products.length == 0) return null;

    //informando que está processando
    isLoading = true;
    //atualiza a tela para que o progressbar apareça
    notifyListeners();
    //pegando os tres preços
    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();
    //criando o pedido no firebase
    DocumentReference refOrder =
        await Firestore.instance.collection("orders").add({
      "clientId": user.firebaseUser.uid,
      //transformando lista de produtos em uma lista de mapas
      "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shipPrice": shipPrice,
      "productsPrice": productsPrice,
      "discount": discount,
      "totalPrice": productsPrice - discount + shipPrice,
      //status do pedido 1= preparando
      "status": 1
    });

    //salvando o numero do pedido no usuário
    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("orders")
        .document(refOrder.documentID)
        .setData({"orderId": refOrder.documentID});

    //removendo os produtos do carrinho
    //pegando todos os produtos do carrinho
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("cart").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }
    //limpando a lista local
    products.clear();

    cuponCode = null;
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;



  }

  //recuperando os itens do carrinho
  void _loadcartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();
    //configurando lista de produtos. Mapeando cada produto
    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }
}
