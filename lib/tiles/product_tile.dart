import 'package:docessuh/datas/product_data.dart';
import 'package:docessuh/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  //vai receber um productdata e o tipo
  final String type;
  final ProductData product;

  //construtor
  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    //InkWell utilizando para que a area fique clicável
    return InkWell(
      onTap: (){
        //para chamar a tela do produto
        Navigator.of(context).push(
          //abrindo a tela com um produto especifico
          MaterialPageRoute(builder: (context)=> ProductScreen(product))

         );
      },
      child: Card(
        child: type == "grid"
            ? Column(
                //stretch para esticar as imagens
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //alinhamento da coluna
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      product.images[0],
                      //para preencher   o espaço
                      fit: BoxFit.cover,
                    ),
                  ),
                  //para que o texto ocupe o restante do espaço d cartão
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "R\$ ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ))
                ],
              )
            : Row(
          children: [
            Flexible(
                flex: 1,
                child: Image.network(
                  product.images[0],
                  //para preencher   o espaço
                  fit: BoxFit.cover,
                  height: 250.0,
                )
            ),
            Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "R\$ ${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
            )
          ],

        ),
      ),
    );
  }
}
