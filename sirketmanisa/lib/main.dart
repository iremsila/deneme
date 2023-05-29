import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirketmanisa/provider/theme_proivder.dart';
import 'package:sirketmanisa/splash_screen/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider(ThemeData(brightness: Brightness.light, primarySwatch: Colors.cyan)),
      child:  MyApp(key: UniqueKey(),),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProviderData = Provider.of<themeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
      theme: themeProviderData.getTheme(),
    );
  }
}
