import 'package:path/path.dart' as p;
String fileType(var path){
    // final path = '/some/path/to/file/file.dart';
    String extension = p.extension(path);
    return extension;
  }