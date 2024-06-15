import 'package:java_toys/constant/url_constant.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/util/util.dart';

class AuthService {
  Future<User> login({
    required String email,
    required String password,
  }) async {
    User result;
    result = userDummy;
    try {
      final response = await Api.createDio().post(
        '${baseUrl}login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['data'];
        final user = User.fromJson(data);
        result = user;
      } else {}
    } catch (e) {}
    return result;
  }

  Future<User> register({
    required String nama,
    required String email,
    required String password,
  }) async {
    User result;
    result = userDummy;
    try {
      final response = await Api.createDio().post(
        '${baseUrl}register',
        data: {
          'nama': nama,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final item = response.data;
        final data = item['data'];
        final user = User(
          id: 0,
          nama: data['nama'],
          alamat: '',
          provinsi: '',
          kota: '',
          kodePos: '',
          email: data['email'],
          noTelp: '',
          apiToken: data['api_token'],
          provIndex: '',
          admin: '0',
        );
        print(user.toJson());
        result = user;
      } else {
        print('error');
      }
    } catch (e) {}
    return result;
  }
}
