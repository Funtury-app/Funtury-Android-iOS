import 'package:flutter/material.dart';
import 'package:web3dart/credentials.dart';

class TradeDetailPageController {
  TradeDetailPageController(
      {required this.context,
      required this.setState,
      required this.marketAddress});

  late BuildContext context;
  late void Function(VoidCallback) setState;
  late EthereumAddress marketAddress;

  bool isYesDiagram = true;
  bool isBuyingPosition = true;
  bool isYesPosition = true;
  bool marketInfoLoading = false;

  int slidingYesNoDiagram = 0;
  int slidingPosition = 0;

  Future<void> init() async {
    setState(() {
      marketInfoLoading = true;
    });

    setState(() {
      marketInfoLoading = false;
    });
  }

  void switchDiagram(int? newValue) {
    if (newValue == null) return;
    setState(() {
      slidingYesNoDiagram = newValue;
      isYesDiagram = newValue == 0 ? true : false;
    });
  }

  void switchPosition(int? newValue) {
    if (newValue == null) return;

    setState(() {
      slidingPosition = newValue;
      isBuyingPosition = newValue == 0 ? true : false;
    });
  }

  void switchYesNoOutcome(bool isYes) {
    setState(() {
      isYesPosition = isYes;
    });
  }
}
