import 'package:flutter/material.dart';
import 'package:java_toys/models/models.dart';
import 'package:java_toys/service/service.dart';
import 'package:java_toys/util/util.dart';

class AuthProvider extends ChangeNotifier {
  User user = userDummy.copyWith();

  bool loading = false;
  bool isLogin = true;

  final key = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  setRegister() {
    isLogin = !isLogin;
    notifyListeners();
  }

  Future<User> checkUser() async {
    loading = true;
    final email = await Preference.getPreferenceEmail();
    final password = await Preference.getPreferencePassword();
    user = (await AuthService().login(
      email: email,
      password: password,
    ));
    loading = false;
    notifyListeners();
    return user;
  }

  Future<User> login() async {
    loading = true;
    user = (await AuthService().login(
      email: email.text,
      password: password.text,
    ));
    loading = false;
    Preference.setPreference(
      email: email.text,
      password: password.text,
    );
    email.clear();
    password.clear();
    notifyListeners();
    return user;
  }

  Future<User> register() async {
    loading = true;
    user = (await AuthService().register(
      nama: name.text,
      email: email.text,
      password: password.text,
    ));
    loading = false;
    name.clear();
    notifyListeners();
    return user;
  }

  logout() async {
    loading = true;
    Preference.setPreference(
      email: '',
      password: '',
    );
    loading = false;
    notifyListeners();
  }
}
