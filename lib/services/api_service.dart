import 'package:dio/dio.dart';
import 'package:mockapi_flutter/constants.dart';
import 'package:mockapi_flutter/models/user.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<User>> getUsers() async {
    try {
      Response response = await dio.get('/users');
      List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<User> createUser(String name, String city) async {
    try {
      Response response = await dio.post('/users', data: {'name': name, 'city': city});
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<User> updateUser(String id, String name, String city) async {
    try {
      Response response = await dio.put('/users/$id', data: {'name': name, 'city': city});
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await dio.delete('/users/$id');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
