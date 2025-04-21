import 'package:flutter/material.dart';
import 'package:funtury/Authenticatoin/login_page.dart';
import 'package:funtury/MainPage/home_page.dart';

class RouteMap {
  // Regist path for page
  static const loginPage = '/loginPage';
  static const homePage = '/homePage';

  // Bind page to path
  static Map<String, WidgetBuilder> routes={
    loginPage: (context) => const LoginPage(),
    homePage: (context) => const Homepage(),
  };
}