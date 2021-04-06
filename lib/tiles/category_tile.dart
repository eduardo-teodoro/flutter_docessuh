import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docessuh/screens/category_screen.dart';
import 'package:flutter/material.dart';
class CategoryTile extends StatelessWidget {

  //recebe o nome e o icone
  final DocumentSnapshot snapshot;

  //construtor
  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["title"]),
      //sinal de maior na direita
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoryScreen(snapshot))

        );


      },
    );
  }
}
