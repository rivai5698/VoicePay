import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_manager/websocket_manager.dart';

class VoiceMessage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}
class _MyAppState extends State<VoiceMessage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _urlController =
  TextEditingController(text: 'ws://103.74.122.136:8085/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)44100,+format=(string)S16LE,+channels=(int)1');
  final TextEditingController _messageController = TextEditingController();
  WebsocketManager socket;

  String _message = '';
  String _closeMessage = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Websocket Manager Example'),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: _urlController,
            ),
            Wrap(
              children: <Widget>[
                RaisedButton(
                  child: Text('CONFIG'),
                  onPressed: () =>
                  socket = WebsocketManager(_urlController.text),
                ),
                RaisedButton(
                  child: Text('CONNECT'),
                  onPressed: () {
                    if (socket != null) {
                      socket.connect();
                    }
                  },
                ),
                RaisedButton(
                  child: Text('CLOSE'),
                  onPressed: () {
                    if (socket != null) {
                      socket.close();
                    }
                  },
                ),
                RaisedButton(
                  child: Text('LISTEN MESSAGE'),
                  onPressed: () {
                    if (socket != null) {
                      socket.onMessage((dynamic message) {
                        print('New message: $message');
                        setState(() {
                          _message = message.toString();
                        });
                      });
                    }
                  },
                ),
                RaisedButton(
                  child: Text('LISTEN DONE'),
                  onPressed: () {
                    if (socket != null) {
                      socket.onClose((dynamic message) {
                        print('Close message: $message');
                        setState(() {
                          _closeMessage = message.toString();
                        });
                      });
                    }
                  },
                ),
                RaisedButton(
                  child: Text('ECHO TEST'),
                  onPressed: () => WebsocketManager.echoTest(),
                ),
              ],
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (socket != null) {
                      socket.send(_messageController.text);
                    }
                  },
                ),
              ),
            ),
            Text('Received message:'),
            Text(_message),
            Text('Close message:'),
            Text(_closeMessage),
          ],
        ),
      ),
    );
  }
}



// class _MyAppState extends State<VoiceMessage> {
//   RecorderStream _recorder = RecorderStream();
//   PlayerStream _player = PlayerStream();
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('wss://dev.interits.com/asr/stream/socket/16k/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)44100,+format=(string)S16LE,+channels=(int)1'),
//   );
//   List<Uint8List> _micChunks = [];
//   bool _isRecording = false;
//   bool _isPlaying = false;
//
//   StreamSubscription _recorderStatus;
//   StreamSubscription _playerStatus;
//   StreamSubscription _audioStream;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlugin();
//   }
//
//   @override
//   void dispose() {
//     _recorderStatus?.cancel();
//     _playerStatus?.cancel();
//     _audioStream?.cancel();
//     super.dispose();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlugin() async {
//     _recorderStatus = _recorder.status.listen((status) {
//       if (mounted)
//         setState(() {
//           _isRecording = status == SoundStreamStatus.Playing;
//         });
//     });
//
//     _audioStream = _recorder.audioStream.listen((data) {
//       if (_isPlaying) {
//         _player.writeChunk(data);
//       } else {
//         _micChunks.add(data);
//       }
//     });
//
//     _playerStatus = _player.status.listen((status) {
//       if (mounted)
//         setState(() {
//           _isPlaying = status == SoundStreamStatus.Playing;
//         });
//     });
//
//     await Future.wait([
//       _recorder.initialize(),
//       _player.initialize(),
//     ]);
//   }
//
//   void _play() async {
//     await _player.start();
//
//     if (_micChunks.isNotEmpty) {
//       for (var chunk in _micChunks) {
//         await _player.writeChunk(chunk);
//       }
//       _micChunks.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               iconSize: 96.0,
//               icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
//               onPressed:
//               //_isRecording ? _recorder.stop : _recorder.start,
//                   (){
//                 if(_isRecording){
//                   _recorder.stop();
//                 }else{
//                   _recorder.start();
//                 }
//                 _channel.sink.add(_recorder)
//                 ;},
//             ),
//             StreamBuilder(
//               stream: _channel.stream,
//               builder: (context, snapshot) {
//                 return Text(snapshot.hasData ? '${snapshot.data}' : '');
//               },
//             ),
//             IconButton(
//               iconSize: 96.0,
//               icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//               onPressed: _isPlaying ? _player.stop : _play,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }