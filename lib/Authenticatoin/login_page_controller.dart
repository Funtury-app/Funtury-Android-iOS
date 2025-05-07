import 'package:flutter/material.dart';
import 'package:funtury/Service/wallet_service.dart';
import 'package:funtury/route_map.dart';

class LoginPageController {
  LoginPageController({
    required this.context,
    required this.setState,
  });

  late BuildContext context;
  late void Function(VoidCallback) setState;

  // late WalletService walletService;

  bool isConnecting = false;

  Future init() async{
    // walletService = Provider.of<WalletService>(context);
    // if (walletService.isConnected) {
    //   Navigator.of(context).pushReplacementNamed(RouteMap.homePage);
    //   debugPrint("Wallet address: ${walletService.address}"); // Debugging line
    // }
    return;
  }

  Future<void> loginWallet() async {
    if (isConnecting) return;
    setState(() {
      isConnecting = true;
    });

    try {
      // if (!walletService.isConnected) {
      //   await walletService.connectWallet(context);
      // }
      // if (context.mounted) Navigator.of(context).pushReplacementNamed(RouteMap.homePage);
      // debugPrint("Wallet address: ${walletService.address}");
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text(
                    "Failed to connect to wallet. Please try again."),
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
        debugPrint("Login error: $e");
      }
    }

    if (context.mounted) {
      setState(() {
        isConnecting = false;
      });
    }
    return;
  }
}
