import 'package:flutter/material.dart';
import 'package:funtury/Service/reown_service.dart';
import 'package:funtury/route_map.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';

class LoginPageController {
  LoginPageController({
    required this.context,
    required this.setState,
  });

  late BuildContext context;
  late void Function(VoidCallback) setState;

  Future init() async {
    try {
      if(ReownService.service!.appKitModal!.status != ReownAppKitModalStatus.initialized) {
        await ReownService.service!.init();
      }

      if (ReownService.service!.appKitModal!.isConnected && context.mounted) {
        Navigator.of(context).pushNamed(RouteMap.homePage);
      }
    } catch (e) {
      debugPrint("Error initializing ReownService: $e");
    }

    return;
  }

  Future<void> loginWallet() async {
    ReownService.service!.appKitModal!.openModalView().then((value) {
      if (ReownService.service!.appKitModal!.isConnected && context.mounted) {
        Navigator.of(context).pushNamed(RouteMap.homePage);
      }
    });
    return;
  }
}
