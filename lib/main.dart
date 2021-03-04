import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evnet_agents/screens/object/add_objects_screen.dart';
import 'package:evnet_agents/screens/object/your_objects_screen.dart';
import 'package:evnet_agents/screens/auth/auth_screen.dart';
import 'package:evnet_agents/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './screens/category_meals_screen.dart';
import 'screens/agent_main/agent_main_screen.dart';
import 'screens/customer/add_customer_screen.dart';
import 'screens/customer/your_customers_screen.dart';
import 'package:evnet_agents/screens/object/object_item_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(0xFF1B5E20, color);
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('tr', ''), // Turkish, no country code
              // const Locale('se', ''), // Swedish, no country code
            ],
            title: 'EvNet',
            theme: ThemeData(
              primarySwatch: colorCustom,
              backgroundColor: Colors.blue[900],
              accentColor: Colors.lightBlue,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: colorCustom,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              fontFamily: 'Raleway',
              textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  )),
            ),
            routes: {
              // '/': (ctx) => TabsScreen(),
              CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
              AddObjectScreen.routeName: (ctx) => AddObjectScreen(),
              AddCustomerScreen.routeName: (ctx) => AddCustomerScreen(),
              YourObjectsScreen.routeName: (ctx) => YourObjectsScreen(),
              ObjectItemScreen.routeName: (ctx) => ObjectItemScreen(),
              YourCusromerScreen.routeName: (ctx) => YourCusromerScreen(),
            },
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SplashScreen();
                      }
                      if (userSnapshot.hasData) {
                        return AgentMainScreen();
                        // FirebaseAuth.instance.signOut();

                        // return AuthScreen();
                      }
                      return AuthScreen();
                    }),
          );
        });
  }
}
