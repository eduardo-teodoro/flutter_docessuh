import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {


  final IconData icon;
  final String text;
  final PageController controller;
//variavel para controlar a pagina que será exibida
  final int page;

  //construtor
  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: (){
          //fechando navigatordrwer
          Navigator.of(context).pop();
          //abrindo pagina solicitada
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32.0,
                color: controller.page.round() == page ?
                Theme.of(context).primaryColor : Colors.grey[700],

              ),
              SizedBox(width: 32.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.grey[700],

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
