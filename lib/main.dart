import 'package:bettingoddscalculator/blocs/best_odd_provider.dart';
import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:bettingoddscalculator/blocs/single_odd_calc_provider.dart';
import 'package:bettingoddscalculator/screens/rootpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'ad_state.dart';
import 'blocs/glossary_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);

  runApp(MultiProvider(providers: [
    Provider.value(value: adState),
    ChangeNotifierProvider(create: (_) => SettingsProvider()),
    ChangeNotifierProvider(create: (_) => SingleOddCalculationProvider()),
    ChangeNotifierProvider(create: (_) => BestOddProvider()),
    ChangeNotifierProvider(create: (_) => GlossaryProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var settingsBloc = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      title: 'Bet calculator',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      /*   localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('es', ''), // Spanish, no country code
      ], */
      theme: settingsBloc.darkModeSetting
          ? buildThemeData()
          : ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.

              primaryColor:
                  Provider.of<SettingsProvider>(context).primaryThemeColor,
              primaryColorLight:
                  Provider.of<SettingsProvider>(context).primaryLightThemeColor,
              iconTheme: IconThemeData(
                color: Provider.of<SettingsProvider>(context).primaryThemeColor,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                elevation: 0,
                backgroundColor:
                    Provider.of<SettingsProvider>(context).primaryThemeColor,
              ),
              scaffoldBackgroundColor:
                  Provider.of<SettingsProvider>(context).primaryLightThemeColor,
            ),
      home: RootPage(),

      //LaunchScreen(),
    );
  }

  ThemeData buildThemeData() => ThemeData.dark().copyWith();
}
