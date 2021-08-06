import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';



class MessagesScreen extends StatefulWidget{
  @override
    @override
    _MyHomePageState createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MessagesScreen>{
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://dev.interits.com/asr/stream/socket/16k/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)16000,+format=(string)S16LE,+channels=(int)1&token=jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M'),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 300,),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }



}


// import 'package:flutter/material.dart';
//
// import 'components/body2.dart';
// import 'components/constants.dart';
//
//
//
// class MessagesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: Body2(),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       title: Row(
//         children: [
//           BackButton(),
//           CircleAvatar(
//             backgroundImage: AssetImage("assets/images/Profile Image.png"),
//           ),
//           SizedBox(width: kDefaultPadding * 0.75),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Smazer",
//                 style: TextStyle(fontSize: 16),
//               ),
//               Text(
//                 "Smart AI Assistant",
//                 style: TextStyle(fontSize: 12),
//               )
//             ],
//           )
//         ],
//       ),
//       // actions: [
//       //   IconButton(
//       //     icon: Icon(Icons.local_phone),
//       //     onPressed: () {},
//       //   ),
//       //   IconButton(
//       //     icon: Icon(Icons.videocam),
//       //     onPressed: () {},
//       //   ),
//       //   SizedBox(width: kDefaultPadding / 2),
//       // ],
//     );
//   }
// }
