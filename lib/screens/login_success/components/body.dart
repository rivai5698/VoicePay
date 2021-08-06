import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/test_module/credit_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.black26,
              backgroundImage: AssetImage("assets/images/success.jpg")
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Trương Hữu Thắng",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(22),
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.4),

        Align(
          alignment: Alignment.center,
            child: ButtonTheme(
              minWidth: 150.0,
              height: 60.0,
              child: RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                 // Navigator.pushNamed(context, HomeScreen.routeName);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SimpleCreditCardSlider()));
                },
                child: Text("Tiếp tục",style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
        )


       // Spacer(),
      //  SizedBox(width: SizeConfig.screenWidth*1,),

        // SizedBox(
        //
        //   child: ButtonTheme(
        //     minWidth: 150.0,
        //     height: 60.0,
        //     child: RaisedButton(
        //       color: Colors.blueAccent,
        //       onPressed: () {
        //         Navigator.pushNamed(context, HomeScreen.routeName);
        //
        //       },
        //       child: Text("Tiếp tục",style: TextStyle(fontSize: 20,color: Colors.white),),
        //     ),
        //   ),
        //),
          // child: DefaultButton(
          //
          //   text: "Tiếp tục",
          //   press: () {
          //     Navigator.pushNamed(context, HomeScreen.routeName);
          //   },
          //),

        //Spacer(),
      ],
    );
  }
}
