//classe para armazenar um produto do carrinho
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docessuh/datas/product_data.dart';

class CartProduct{

  //id do cart
  String cid;
  //categoria do produto
  String category;
  //id do produto
  String pid;
  // quantidade solicitada do produto
  int quantity;
  //tamanho
  String size;

  CartProduct();


  ProductData productData;
  //construtor
  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    size = document.data["size"];

  }

  Map<String, dynamic> toMap(){
    return{
      "category":category,
      "pid":pid,
      "quantity":quantity,
      "size":size,
      "product": productData.toResumedMap()
    };
  }





}