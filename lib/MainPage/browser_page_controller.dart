import 'package:flutter/material.dart';
import 'package:funtury/Data/browser_event.dart';
import 'package:funtury/Service/ganache_service.dart';
import 'package:web3dart/credentials.dart';

class BrowserPageController {
  BrowserPageController({
    required this.context,
    required this.setState,
  });
  late BuildContext context;
  late void Function(VoidCallback) setState;
  // ReownAppKitModal appKitModal = ReownService.service!.appKitModal!;
  GanacheService ganacheService = GanacheService();

  List<BrowserEvent> events = [];

  List<EthereumAddress> marketAddresses = [];

  Future<void> getAllMarkets() async{
    marketAddresses = await ganacheService.queryAllMarket();
    return;
  }

  Future<void> init() async{
    // final result = await Future.wait([
    //   ganacheService.queryAllMarket(),
    // ]);
    // marketAddresses = result[0];

    // for(int i = 0 ; i < marketAddresses.length ;i ++){
    //   events.add(BrowserEvent(marketAddress: marketAddresses[i], yesProbability: Random().nextInt(100), noProbability: Random().nextInt(100)));
    // }

    events.add(BrowserEvent(marketAddress: EthereumAddress.fromHex("0x82Be6C4b686dF7908aB0771f18b4e3C134e923FD"), yesProbability: 20, noProbability: 80));
    events.add(BrowserEvent(marketAddress: EthereumAddress.fromHex("0x82Be6C4b686dF7908aB0771f18b4e3C134e923FD"), yesProbability: 40, noProbability: 60));

    if(
      context.mounted){
      setState(() {});
    }
  }

  Future<void> refresh() async{

  }
  
}

  // Future<void> logoutWallet() async {
  //   appKitModal.disconnect().then((value) {
  //     if (appKitModal.isConnected && context.mounted) {
  //       Navigator.of(context).pushReplacementNamed(RouteMap.loginPage);
  //     }
  //   });
  //   return;
  // }