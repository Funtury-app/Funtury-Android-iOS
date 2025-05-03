import 'package:flutter/material.dart';
import 'package:funtury/MainPage/browser_page_controller.dart';
import 'package:reown_appkit/reown_appkit.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  late BrowserPageController browserPageController;

  @override
  void initState() {
    super.initState();
    browserPageController = BrowserPageController(
      context: context,
      setState: setState,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      ElevatedButton(onPressed: (){
        browserPageController.burnFrom();
      }, child: Text("burnToken")),
      AppKitModalNetworkSelectButton(appKit: browserPageController.appKitModal),
      AppKitModalAccountButton(appKitModal: browserPageController.appKitModal),
      AppKitModalBalanceButton(appKitModal: browserPageController.appKitModal),
      AppKitModalConnectButton(
        appKit: browserPageController.appKitModal,
        custom: ElevatedButton(
            onPressed: browserPageController.logoutWallet,
            child: Text("log out")),
      ),
      
    ]));
  }
}
