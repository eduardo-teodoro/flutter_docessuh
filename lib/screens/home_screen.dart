import 'package:docessuh/tabs/home_tab.dart';
import 'package:docessuh/tabs/ordens_tab.dart';
import 'package:docessuh/tabs/places_tab.dart';
import 'package:docessuh/tabs/products_tab.dart';
import 'package:docessuh/widgets/cart_button.dart';
import 'package:docessuh/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _pageController = PageController();
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          //menu a esquerda do app
          drawer: CustomDrawer(_pageController),
          //botão
          floatingActionButton: CartButton(),
        ),
        //outras paginas
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          //botão
          floatingActionButton: CartButton(),

        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),

        ),
        //meus pedidos
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),

        )
      ],
    );
  }
}
