import 'package:flutter/material.dart';
import 'package:funtury/Authenticatoin/login_page.dart';
import 'package:funtury/MainPage/home_page.dart';
import 'package:funtury/MainPage/trade_detail_page.dart';
import 'package:web3dart/credentials.dart';

class RouteMap {
  // Regist path for page
  static const loginPage = '/loginPage';
  static const homePage = '/homePage';
  static const tradeDetailPage = '/tradeDetailPage';

  // Bind page to path
  static Map<String, WidgetBuilder> routes = {
    loginPage: (context) => const LoginPage(),
    homePage: (context) => const Homepage(),
    tradeDetailPage: (context) {
      final EthereumAddress marketAddress;
      final int? userYesPosition;
      final int? userNoPosition;
      (marketAddress, userYesPosition, userNoPosition) =
          ModalRoute.of(context)?.settings.arguments as (EthereumAddress, int?, int?);
      return TradeDetailPage(marketAddress: marketAddress, userYesShares: userYesPosition, userNoShares: userNoPosition,);
    },
  };
}
