import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../size_config.dart';


class TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
              ),

              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget> [
                    Image.asset(
                      "assets/images/ps4_console_white_1.png",
                      height: getProportionateScreenHeight(100),
                      width: getProportionateScreenWidth(100),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tay cầm PS4™",
                          style: TextStyle(fontSize:15),
                        ),
                        Text("Giá: 64,99\$")
                      ],
                    ),

                  ]
              ),
              SizedBox(
                height: 200,
              ),
              ButtonTheme(
                minWidth: 150.0,
                height: 60.0,
                child: RaisedButton(
                  color: Colors.cyan,
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);

                  },
                  child: Text("Xác nhận",style: TextStyle(fontSize: 20,color: Colors.white),),
                ),

              )
            ],
          ),
        ),

      ),

    );
  }

}


