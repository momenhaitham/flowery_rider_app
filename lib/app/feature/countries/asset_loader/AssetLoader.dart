import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract class JsonLoader {
  Future<String> loadString(String path);
}

@LazySingleton(as: JsonLoader)
class FlutterAssetLoader implements JsonLoader {
  @override
  Future<String> loadString(String path) {
    return rootBundle.loadString(path);
  }
}
