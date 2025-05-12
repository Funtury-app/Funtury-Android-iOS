import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:funtury/route_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     // ChangeNotifierProvider(create: (_) => WalletService())
    //   ],
    //   child:
    return MaterialApp(
      title: 'Funtury',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD030),
          primary: const Color(0xFFFFD030),
          secondary: const Color(0xFF000000),
          tertiary: const Color(0xFFFFFFFF),
        ),
        textTheme:
            GoogleFonts.instrumentSansTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
          TargetPlatform.linux: FadeThroughPageTransitionsBuilder(),
          TargetPlatform.windows: FadeThroughPageTransitionsBuilder(),
        },
      )),
      routes: RouteMap.routes,
      initialRoute: RouteMap.homePage,
    );
    // );
  }
}
