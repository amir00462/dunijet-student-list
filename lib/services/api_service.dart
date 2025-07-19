import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  getUsers() {
    Response response = dio.get('');
  }
}
