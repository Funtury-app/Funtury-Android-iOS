import 'package:flutter/material.dart';
import 'package:funtury/Service/ganache_service.dart';
import 'package:web3dart/credentials.dart';

class WalletPageController {
  WalletPageController({
    required this.context,
    required this.setState,
  });

  BuildContext context;
  void Function(VoidCallback) setState;

  late EthereumAddress walletAddress;
  late double balance;
  Map<EthereumAddress, (double, double)> userPosition = {};

  GanacheService ganacheService = GanacheService();

  bool balanceLoading = false;
  bool claimedLoading = false;
  bool alreadyClaimed = false;
  bool positionLoading = false;

  void updateBalance(double newBalance) {
    balance = newBalance;
  }

  Future<void> init() async {
    setState(() {
      balanceLoading = true;
      claimedLoading = true;
    });

    try {
      getAllUserPosition();
      // final result = await ganacheService.getBalance();
      balance = 20.0;
      alreadyClaimed = await ganacheService.checkFreeTokenClaimed();
      walletAddress = GanacheService.userAddress;
    } catch (e) {
      debugPrint("WalletPageController init error: $e");
    }

    if (context.mounted) {
      setState(() {
        balanceLoading = false;
        claimedLoading = false;
      });
    }
  }

  Future<void> getAllUserPosition() async {
    setState(() {
      positionLoading = true;
    });

    try {
      // final marketAddress = await ganacheService.queryAllMarket();

      // for (var address in marketAddress) {
      //   final result = await ganacheService.getUserPosition(address);
      //   if (result.$1 != 0 || result.$2 != 0) {
      //     userPosition[address] = result;
      //   }
      // }
      userPosition[
          EthereumAddress.fromHex("0x82Be6C4b686dF7908aB0771f18b4e3C134e923FD")] =
          (20.0, 80.0);

      debugPrint("WalletPageController getAllUserPosition success");
    } catch (e) {
      debugPrint("WalletPageController getAllUserPosition error: $e");
    }

    setState(() {
      positionLoading = false;
    });
  }

  Future<void> claimedFreeToken() async {
    setState(() {
      claimedLoading = true;
    });

    late bool result;
    try {
      await ganacheService.claimedFreeToken();

      debugPrint("WalletPageController claimedFreeToken success");
      result = true;
    } catch (e) {
      debugPrint("WalletPageController claimedFreeToken error: $e");
      result = false;
    }

    if (result && context.mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Claimed Free Token"),
              content:
                  const Text("You have successfully claimed 500 free tokens!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          });
      alreadyClaimed = true;
      balance += 50.0;
    }

    setState(() {
      claimedLoading = false;
    });
  }
  // Add more methods as needed
}
