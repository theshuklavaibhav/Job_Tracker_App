import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  Future<User> login(String email, String password) async {
    final response = await _api.put('auth.login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save Both tokens on device storage
      await _storage.write(key: 'acess_token', value: data['acess_token']);
      await _storage.write(key: 'refresh_token', value: data['refresh_token']);
      return await getCurrentUser();
    } else {
      throw Exception('Invalid Email or Password');
    }
  }

  Future<User> register(String email, String password, String fullName) async {
    final response = await _api.post('/auth/register', {
      'email': email,
      'password': password,
      'full_Name': fullName,
    });
    if (response.statusCode == 201) {
      // After Registration Returen user directly to login
      return await login(email, password);
    } else {
      throw Exception("Registration failed. email is already be in use");
    }
  }

  Future<User> getCurrentUser() async {
    final response = await _api.get('auth/me');
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Session Expired');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_tokken');
    await _storage.delete(key: 'refresh_tokken');
  }

  Future<bool> isLoggedIn() async {
    final _token = await _storage.read(key: 'access_token');
    return (_token != null); 
  }
}
