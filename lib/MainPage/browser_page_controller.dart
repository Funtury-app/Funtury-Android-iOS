import 'package:flutter/material.dart';
import 'package:funtury/Service/Contract/contract.dart';
import 'package:funtury/Service/reown_service.dart';
import 'package:funtury/route_map.dart';
import 'package:reown_appkit/reown_appkit.dart';

class BrowserPageController {
  BrowserPageController({
    required this.context,
    required this.setState,
  });
  late BuildContext context;
  late void Function(VoidCallback) setState;
  ReownAppKitModal appKitModal = ReownService.service!.appKitModal!;

  Future<void> logoutWallet() async {
    appKitModal.disconnect().then((value) {
      if (appKitModal.isConnected && context.mounted) {
        Navigator.of(context).pushReplacementNamed(RouteMap.loginPage);
      }
    });
    return;
  }

  Future<void> burnFrom() async {
    try {
      final r1 = appKitModal.getAvailableChains();
      final r2 = appKitModal.selectedChain;
      final r3 = appKitModal.selectedWallet;
      final r4 = appKitModal.getApprovedChains();
      final r5 = appKitModal.getApprovedMethods();
      final r6 = appKitModal.getApprovedEvents();
      final r7 = await appKitModal.loadAccountData();
      // final r8 = await appKitModal.requestAddChain(ReownAppKitModalNetworkInfo(
      //     name: "Funtury",
      //     chainId: "1337",
      //     currency: "T",
      //     rpcUrl: "https://ff27-120-126-194-244.ngrok-free.app",
      //     explorerUrl: "",
      //     isTestNetwork: true));
      final r9 = await appKitModal.requestSwitchToChain(ReownAppKitModalNetworkInfo(
          name: "Funtury",
          chainId: "eip155:1337",
          currency: "T",
          rpcUrl: "https://6722-2001-b400-e174-69a3-a8c8-9e7-ed38-ed46.ngrok-free.app",
          explorerUrl: "",));
      final r10 = await appKitModal.connectSelectedWallet();

      // final r11 = appKitModal.launchConnectedWallet();

      final result = await appKitModal.requestWriteContract(
          topic: appKitModal.session!.topic.toString(),
          chainId: 'eip155:1337',
          deployedContract: Contract.tokenERC20,
          functionName: "burnFrom",
          parameters: [
            '0xFbe0a8f15b2749fa8BB6263A8ac84E3a0D7995Ad',
            BigInt.from(1e+18)
          ],
          transaction: Transaction(
              from: EthereumAddress.fromHex(
                  "0x7Ff027B41e733b955de337A07928fa1b2f96C993")));
      debugPrint("Process success");
    } catch (e) {
      debugPrint("Error occur: ${e.toString()}");
    }
    return;
  }
}
