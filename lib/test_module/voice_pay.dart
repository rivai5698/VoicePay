import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'message_screen.dart';




class VoicePay extends StatefulWidget {
  //final String phoneStr;
  // final Data data;
  // LoginPage({this.data});
  @override
  _VoicePay createState() => _VoicePay();
}
String myurl;
String myData;


class Data {
  String url;
  Data ({this.url});
  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class ResultResponse {
  Data data;
  String msg;
  int status;
  ResultResponse({
    this.data,
    this.msg,
    this.status,
  });

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    return ResultResponse(
        msg: json['msg'],
        status: json['status'],
        data: json['data'] != null ? new Data.fromJson(json['data']) : null
    );
  }
}

_getUrl(String text) async {
  String token = "jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M";

  var url = "http://tts.interits.com/api/v2/path";
  var request = new http.Request('POST', Uri.parse(url));
  var body = {'token':token, 'text':text,'voiceId':'2'};
  request.bodyFields = body;

  http.Response response = await http.post(Uri.parse(url),body: body);
  if (response.statusCode == 200){
    ResultResponse.fromJson(jsonDecode(response.body));
    print(response.body);
    //myStatus =  ResultResponse.fromJson(jsonDecode(response.body)).status;
    Data dta = ResultResponse.fromJson(jsonDecode(response.body)).data;
    myurl = dta.url;
    print( ResultResponse.fromJson(jsonDecode(response.body)).status);

    print("Success!");

  }else{

    print("Error..................");
    print(response.statusCode);
  }
}



class _VoicePay extends State<VoicePay>{
 AudioPlayer audioPlayer = new AudioPlayer();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.cyan),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Container(
              //   constraints: BoxConstraints.loose(Size(double.infinity,40)),
              //   alignment: AlignmentDirectional.topStart,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              //     child: Text(
              //       "Trang Đăng Nhập",
              //       style: TextStyle(fontSize: 18,color: Colors.blue),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 70,
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black26,
                backgroundImage: AssetImage("assets/images/Profile Image.png")
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  "Xin chào, Tôi là Smazer\n Tôi là trợ lý ảo của bạn.\nHãy nói \"Tôi muốn thanh toán\" để mua hàng!",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              // Text(
              //   "Đăng nhập",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xff606470)
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 20),
                child: Text(
                  "OK Smazer, Tôi muốn thanh toán",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,color: Colors.cyan),
                ),
                // child: TextField(
                //
                //   style: TextStyle(fontSize: 18, color: Colors.black),
                //   keyboardType: TextInputType.number,
                //   maxLength: 10,
                //   decoration: InputDecoration(
                //     labelText: "Số điện thoại",
                //     prefixIcon: Container(
                //       width: 50,
                //       child: Image.asset(
                //           'assets/introduction_animation/phone_ic.png'),
                //     ),
                //     border: OutlineInputBorder(
                //         borderSide:
                //         BorderSide(color: Color(0xffCED0D2), width: 1),
                //         borderRadius: BorderRadius.all(Radius.circular(6))),
                //   ),
                // ),
              ),
              // TextField(
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 18
              //   ),
              //   obscureText: true,
              //   decoration: InputDecoration(
              //     labelText: "Mật khẩu",
              //     prefixIcon: Container(
              //       width: 50,
              //       child: Image.asset("ic_password.png"),
              //     ),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Color(0xffCED0D2),
              //         width: 1
              //       ),
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(6)
              //       )
              //     )
              //   ),
              // ),
              // Container(
              //   constraints: BoxConstraints.loose(Size(double.infinity,30)),
              //   alignment: AlignmentDirectional.centerEnd,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //     child: Text(
              //       "Quên mật khẩu?",
              //       style: TextStyle(fontSize: 16,color: Color(0xff606470)),
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 100,

                  child: RawMaterialButton(
                    onPressed: () async {
                      onClick();

                      // Navigator.push(
                      //   context, MaterialPageRoute(builder: (context) => MessagesScreen()));

                    },
                    elevation: 2.0,
                    fillColor: Colors.cyan,
                    child: Icon(
                      Icons.mic,
                      size: 45.0,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(

                    ),
                  ),

                  // child: RaisedButton(
                  //   //   {
                  //   //   Navigator.push(context,
                  //   //       MaterialPageRoute(builder: (context) => OtpPage()));
                  //   // },
                  //   child: Text(
                  //     "Đăng nhập",
                  //     style: TextStyle(color: Colors.white, fontSize: 18),
                  //   ),
                  //   color: Color(0xff3277D8),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(6))),
                  // ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              //   child: RichText(
              //     text: TextSpan(
              //         text: "Bạn chưa có tài khoản?",
              //         style: TextStyle(color: Color(0xff606470), fontSize: 16),
              //         children: <TextSpan>[
              //           TextSpan(
              //               recognizer: TapGestureRecognizer()
              //                 ..onTap = () {
              //
              //
              //                 },
              //               text: "Đăng ký tài khoản mới",
              //               style: TextStyle(
              //                   color: Color(0xff3277D8), fontSize: 16))
              //         ]),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
  void onClick(){
setState(() async {
  await _getUrl("Xin chào, Tôi là Smazer Tôi là trợ lý ảo của bạn. Hãy nói Tôi muốn thanh toán để mua hàng!");
  if(myurl!=null){
    audioPlayer.play(myurl,isLocal:true);
    audioPlayer.onPlayerCompletion.listen((event) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => MessagesScreen()));
    });
  }
});


  }
}