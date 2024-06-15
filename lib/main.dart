import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:java_toys/util/util.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToysProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddToyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadImageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        home: const SplashPage(),
      ),
    );
  }
}
