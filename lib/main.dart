import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:islami/home/hadeth/hadeth_details_screen.dart';
import 'package:islami/home/providers/settings_provider.dart';
import 'package:islami/home/quran/sura_details.dart';
import 'package:islami/home_screen.dart';
import 'package:islami/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ChangeNotifierProvider<SettingsProvider>(
      create: (buildContext) {
        return SettingsProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  late SettingsProvider settingsProvider;
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    getValueFromShared();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(settingsProvider.currentLang),
      title: 'Islami',
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SuraDetailsScreen.routeName: (_) => SuraDetailsScreen(),
        HadethDetailsScreen.routeName: (_) => HadethDetailsScreen()
      },
      initialRoute: HomeScreen.routeName,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: settingsProvider.currentTheme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
    );
  }

  void getValueFromShared() async {
    final prefs = await SharedPreferences.getInstance();


    settingsProvider.changeLanguage(prefs.getString("lang") ?? "ar");

    if (prefs.getString("theme") == "light") {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (prefs.getString("theme") == "dark") {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
