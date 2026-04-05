import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // --- Auth Tokens ---
  Future<void> saveToken(String token) async {
    await _box.write('auth_token', token);
  }

  String? getToken() {
    return _box.read<String>('auth_token');
  }
  
  Future<void> removeToken() async {
    await _box.remove('auth_token');
  }

  // --- User Preferences / Details ---
  Future<void> saveUserId(String id) async {
    await _box.write('user_id', id);
  }

  String? getUserId() {
    return _box.read<String>('user_id');
  }

  Future<void> removeUserId() async {
    await _box.remove('user_id');
  }

  Future<void> clearAll() async {
    await _box.erase();
  }
}
