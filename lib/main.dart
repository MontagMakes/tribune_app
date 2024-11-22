import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/screens/screen_home_page/screen_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //saving Theme mode to  
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  //Force portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {

    //Using AdaptiveTheme to set the theme mode
    return AdaptiveTheme(

      light: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Colors.white,
      ),
      dark: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(backgroundColor: kColorSecondary),
          drawerTheme: const DrawerThemeData(backgroundColor: kColorSecondary),
          scaffoldBackgroundColor: kColorPrimary,
          
      ),

      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      
      builder: (theme, dark) => MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: theme,
        darkTheme: dark,
        themeAnimationDuration: const Duration(milliseconds: 500),
        home: const MyHomePage(),
      ),
    );
  }
}

