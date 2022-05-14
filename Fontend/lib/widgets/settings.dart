import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/themes_provider.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<SettingsScreen> {
  dynamic  isDarkTheme;
  List<String> themes = Constant.themes;

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
         elevation: 0.0,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headline1,
        ),

      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(isDarkTheme ? "Dark Theme" : "Light Theme"),
                      trailing: Switch.adaptive(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString(
                              Constant.appTheme, value ? "Dark" : "Light");

                          if (!mounted) return;
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(90),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Setting.png'),
                    alignment: Alignment(0, 8),
                  ),
                ),
              ),
              const SizedBox(height: 250,),
              Container(
                padding: const EdgeInsets.all(70),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Mangaaro_App.png'),
                    alignment: Alignment(0, 50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
