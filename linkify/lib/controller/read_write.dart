import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linkify/controller/webview.dart';
import 'package:path_provider/path_provider.dart';

// class CounterStorage {
  
// }

class ReadWrite{

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileAccessToken async {
    final path = await _localPath;

    return File('$path/accessToken.txt');
  }


  Future<String> getAccessToken() async {
    try {
      final file = await _localFileAccessToken;

      // Read the file
      final accessToken = await file.readAsString();
      return accessToken;
    } catch (e) {
      // If encountering an error, return ""
      return "";
    }
  }

  Future<void> writeAccessToken(String accessToken) async {
    final file = await _localFileAccessToken;

    // Write the file
    file.writeAsString(accessToken);
  }

  Future<File> get _localFileRefreshToken async {
    final path = await _localPath;
    print(path);

    return File('$path/refreshToken.txt');
  }

  Future<void> writeRefreshToken(String refreshToken) async {
    final file = await _localFileRefreshToken;

    // Write the file
    file.writeAsString(refreshToken);
  }


  Future<String> getRefreshToken()async{
    try {
      final file = await _localFileRefreshToken;

      // Read the file
      final refreshToken = await file.readAsString();
      return refreshToken;
    } catch (e) {
      return "";
    }
  }


  // Future<String> getAccessToken()async{
  //   return await readData();
  // }

}
















// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:linkify/controller/webview.dart';
// import 'package:path_provider/path_provider.dart';

// // class CounterStorage {
  
// // }

// class ReadWrite extends StatefulWidget {
//   const ReadWrite({super.key});

//   // final CounterStorage storage;

//   @override
//   State<ReadWrite> createState() => ReadWriteState();
// }

// class ReadWriteState extends State<ReadWrite> {
//   // int _counter = 0;

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }

//   Future<File> get _localFileAccessToken async {
//     final path = await _localPath;

//     return File('$path/storageForTokens/accessToken.txt');
//   }

//   Future<File> get _localFileRefreshToken async {
//     final path = await _localPath;

//     return File('$path/storageForTokens/refreshToken.txt');
//   }

//   Future<String> readData() async {
//     try {
//       final file = await _localFileAccessToken;
//       print(file);
//       // Read the file
//       final accessToken = await file.readAsString();
//       // if(accessToken==""){
//       //   // calling for access token from webview;
//       //   WebContainer();

//       // }else{
//       //   try{
//       //     // callInfo();
//       //   }
//       //   catch(e){
//       //     final file = await _localFileRefreshToken;
//       //     final refreshToken = await file.readAsString();
//       //     // call for access token from refresh token
//       //   }
//       // }

//       return accessToken;
//     } catch (e) {
//       // If encountering an error, return 0
//       return "";
//     }
//   }

//   Future<File> writeCounter(int counter) async {
//     final file = await _localFileAccessToken;

//     // Write the file
//     return file.writeAsString('$counter');
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   widget.storage.readData().then((value) {
//   //     setState(() {
//   //       // _counter = value;
//   //     });
//   //   });
//   // }
//   Future<String> getAccessToken()async{
//     return await readData();
//   }
//   // Future<File> _incrementCounter() {
//   //   setState(() {
//   //     _counter++;
//   //   });

//     // Write the variable as a string to the file.
//     // return widget.storage.writeCounter(_counter);
//   // }

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
//           var t = await fetchAccessToken();
//           if(t==""){
//             print("n/a");
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebContainer()));
//           }else{
//             print("found");
//             print(t);
//           }
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
