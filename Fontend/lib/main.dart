import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mangaaro_app/services/authservice.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './provider/data_provider.dart';
import './provider/themes_provider.dart';
import './utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  await Firebase.initializeApp();
  prefs.then((value) => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          String? theme = value.getString(Constant.appTheme);
            return (
              theme == null ||
              theme.isEmpty ||
              theme == Constant.systemDefault
            )
              ? ThemeProvider(ThemeMode.system)
              : ThemeProvider(
                theme == Constant.dark
                ? ThemeMode.dark
                : ThemeMode.light
              );
            }),
            ChangeNotifierProvider(create: (context) => DataProvider()),
          ],
          child: const Main(),
        ),
  ));
}


class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(context) {
    return MaterialApp(
      title: 'MANGAARO APP',
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: AuthService().handleAuth(),
    );
  }
}
