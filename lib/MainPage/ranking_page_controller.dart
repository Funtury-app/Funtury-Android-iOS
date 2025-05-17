import 'package:flutter/material.dart';
import 'package:funtury/Service/ganache_service.dart';
import 'package:web3dart/credentials.dart';

class RankingPageController {
  final ScrollController rankScroll;
  RankingPageController({
    required this.context,
    required this.setState,
    required this.rankScroll,
  });

  final BuildContext context;
  final void Function(VoidCallback) setState;
  GanacheService ganacheService = GanacheService();

  bool isLoading = false;
  bool showScrollToTopButton = false;

  List<User> userList = [];
  User selfInfo = User(self: true, userAddress: EthereumAddress.fromHex("0xCCc721037E1826E88233a3575551FeAD0311483b"), userBalance: 0);
  int selfPlace = 0;

  Future init() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    try {
      final result = await ganacheService.getAllFunturyUser();
      if (result.$1) {
        List<EthereumAddress> userAddresses = result.$2;
        List<double> userBalance = await Future.wait([
          for (var address in userAddresses)
            ganacheService.getUserBalance(address),
        ]);
        userList = List.generate(userAddresses.length, (index) {
          return User(
            self: userAddresses[index] == GanacheService.userAddress,
            userAddress: userAddresses[index],
            userBalance: userBalance[index],
          );
        });
        userList.sort((a, b) => b.userBalance.compareTo(a.userBalance));

        for (int i = 0; i < userList.length; i++) {
          if (userList[i].self) {
            selfPlace = i + 1;
            selfInfo = userList[i];
            break;
          }
        }
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text(
                    "Failed to load leader board. Please try again."),
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
      }
      debugPrint("Ranking load error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future refresh() async {
    await init();
    return;
  }

  void scrollToTop() {
    rankScroll.animateTo(
      rankScroll.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class User {
  final bool self;
  final EthereumAddress userAddress;
  final double userBalance;

  const User({
    required this.self,
    required this.userAddress,
    required this.userBalance,
  });
}
