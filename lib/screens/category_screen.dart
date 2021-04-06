/*
tela da categoria
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docessuh/datas/product_data.dart';
import 'package:docessuh/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  //construtor
  DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    //para criar a alteração do tipo de tabela no topo da tela
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data['title']),
            centerTitle: true,
            bottom: TabBar(
              //cor para indicar a tab atual
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list))
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              //pegando cada um dos documentos dos produtos
              future: Firestore.instance.collection("products").document(snapshot.documentID)
              .collection("items").getDocuments(),

              builder: (context, snapshot) {
            //se não contem dado
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  //A grade
                  GridView.builder(
                      padding: EdgeInsets.all(4.0),
                      //qtde de itens na horizontal
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //2 itens na horizontal
                        crossAxisCount: 2,
                        //espaçamento no eixo principal
                        mainAxisSpacing: 4.0,
                        //espaçamento no eixo cruzado
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65,
                      ),
                      //qtde de itens na grade
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        //ProductData.fromDocument convert em objeto
                        return ProductTile("grid",data );
                      }
                  ),
                  //A parte da lista
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        //ProductData.fromDocument convert em objeto
                        ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return ProductTile("list", data);
                      }

                  )
                  
                ],
              );
          }
          ),
      ),
    );
  }
}
