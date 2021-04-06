import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docessuh/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      //uma tile onde se clica e a mesma expande
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        //icon na esquerda
        leading: Icon(Icons.card_giftcard),
        //icon na direita
        trailing: Icon(Icons.add),
        //conteudo do card
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite seu cupom"),
              //caso não tenha código aplica um texto vazio
              initialValue: CartModel.of(context).cuponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("coupons")
                    .document(text)
                    .get()
                    .then((docSnap) => {
                      if(docSnap.data != null){
                        CartModel.of(context).setCoupon(text, docSnap.data["percent"]),
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Desconto de ${docSnap.data["percent"]}% aplicado"),
                          backgroundColor: Theme.of(context).primaryColor,)
                        )


                      }else{
                        CartModel.of(context).setCoupon(null, 0),
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Cupom não existente"),
                              backgroundColor: Colors.redAccent,)
                        )

                      }

                });
              },
            ),
          )
        ],
      ),
    );
  }
}
