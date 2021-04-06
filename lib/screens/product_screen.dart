import 'package:carousel_pro/carousel_pro.dart';
import 'package:docessuh/datas/cart_product.dart';
import 'package:docessuh/datas/product_data.dart';
import 'package:docessuh/models/cart_model.dart';
import 'package:docessuh/models/user_model.dart';
import 'package:docessuh/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;


  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  //construtor para o state para não ter que ficar usando o widget.product
  final ProductData product;
  String size;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    //Scafold para a barra no topo
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      //para conseguir rolagem na tela
      body: ListView(
        children: [
          //largura dividido pela altura
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              //todas informações dendro do widget tentará ocupar o máximo de espaço
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    //orientação da gridview
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //qtde de linhas exibidas
                        crossAxisCount: 1,
                        //espaçamento no eixo principal
                        mainAxisSpacing: 8.0,
                        //
                        childAspectRatio: 0.5),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    // onPressed: size != null? () {
                    // }:null,
                    onPressed: (){
                      //verificando se existe usuário logado
                      if( UserModel.of(context).isLoggedIn() ){
                        //adiciona ao carrinho
                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity =1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.productData = product;

                        CartModel.of(context).addCartItem(cartProduct);
                        //abre a tela do carrinho

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CartScreen())
                        );
                      }else{
                        //abre a tela para o usuário logar
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }

                    },
                    child: Text( UserModel.of(context).isLoggedIn() ?
                      "Adicionar ao carrinho"
                      :
                      "Entre pra comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0

                  ),

                )


              ],
            ),
          )
        ],
      ),
    );
  }
}
