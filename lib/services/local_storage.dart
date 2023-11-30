import 'package:localstorage/localstorage.dart';

class Storage {
  final LocalStorage storage = LocalStorage('.json');

  void set(String key, dynamic value) {
    storage.setItem(key, value.toJSONEncodable());
  }

  dynamic get(String key) {
    return storage.getItem(key);
  }
}
