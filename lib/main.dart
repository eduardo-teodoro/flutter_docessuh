import 'package:docessuh/models/cart_model.dart';
import 'package:docessuh/screens/home_screen.dart';
import 'package:docessuh/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //vem do pakage models
    return ScopedModel<UserModel>(
        model: UserModel(),
        //ao trocar de usuário o carrinho é refeito
        child: ScopedModelDescendant<UserModel>(
          builder: (context,child, model){
            return ScopedModel<CartModel>(
              //passando o usermodel como parâmetro
              model: CartModel(model),
              child: MaterialApp(
                title: 'Doces Suh',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  //cor da barra, botão etc
                  primaryColor: Color.fromARGB(255, 4, 125, 141),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                //tela principal
                //home: HomeScreen(),
                home: HomeScreen(),
              ),
            );

          },
        )
    );
  }
}
