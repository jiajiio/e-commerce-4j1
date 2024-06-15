import 'package:flutter/material.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/constant/color_constant.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: auth.isLogin
              ? Form(
                  key: auth.key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: auth.email,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: auth.password,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: auth.loading
                              ? null
                              : () async {
                                  if (auth.key.currentState!.validate()) {
                                    var user = await auth.login();
                                    if (user.id != 0) {
                                      if (context.mounted) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                          child: auth.loading
                              ? const CircularProgressIndicator()
                              : const Text('Masuk'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun?',
                          ),
                          GestureDetector(
                            onTap: () {
                              auth.setRegister();
                            },
                            child: Text(
                              'daftar',
                              style: TextStyle(
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Form(
                  key: auth.key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: auth.name,
                        decoration: const InputDecoration(
                          hintText: 'Nama',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input nama';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: auth.email,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: auth.password,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: auth.loading
                              ? null
                              : () async {
                                  if (auth.key.currentState!.validate()) {
                                    var user = await auth.register();
                                    if (user.nama != '') {
                                      var user = await auth.login();
                                      if (user.id != 0) {
                                        if (context.mounted) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage(),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  }
                                },
                          child: auth.loading
                              ? const CircularProgressIndicator()
                              : const Text('Daftar'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun?',
                          ),
                          GestureDetector(
                            onTap: () {
                              auth.setRegister();
                            },
                            child: Text(
                              'masuk',
                              style: TextStyle(
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

}
