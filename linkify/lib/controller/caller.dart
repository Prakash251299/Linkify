// import 'package:flutter/material.dart';
// import 'package:linkify/controller/call_spotify.dart';
// import 'package:linkify/controller/read_write.dart';
// import 'package:linkify/controller/webview.dart';

// class Caller extends StatelessWidget {
//   Caller({super.key});
//   ReadWrite _readWrite = ReadWrite();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reading and Writing Files'),
//       ),
//       body: Center(
//         child: Text(""
//           // 'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var t = await _readWrite.getAccessToken();
//           if(t==""){
//             print("n/a");
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebContainer()));
//           }else{
//             print("found");
//             // try{
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => CallSpotify()));
//             // }catch(e){
//               // update access token using refresh token

//               // callInfo();
//             // }
//             // print(t);
//           }
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
