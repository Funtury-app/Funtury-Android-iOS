import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

class LoginPageController {
  LoginPageController({
    required this.context,
    required this.setState,
  });

  late BuildContext context;
  late void Function(VoidCallback) setState;

  late ReownAppKitModal appKitModal;

  Future init() async {
    appKitModal = ReownAppKitModal(
      context: context,
      logLevel: LogLevel.all,
      projectId: '36e52185ba38144b6468153c77ef73ac',
      metadata: const PairingMetadata(
        name: 'funtury',
        description: 'funtury description',
        url: 'https://funtury.com',
        icons: ['https://funtury.com/logo.png'],
        // TODO check the docs on how to configure the redirect object https://docs.reown.com/appkit/flutter/core/usage#redirect-to-your-dapp
        redirect: Redirect(
          native: 'funtury://',
          universal: 'https://funtury.com/app',
        ),
      ),
      featuredWalletIds: {
      },
      includedWalletIds: {
        'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96',
      },
      excludedWalletIds: {

      },
      // If you enable social features you will have to whitelist your bundleId/packageName under the Mobile Application IDs secion in https://cloud.reown.com/app
      // Please also follow carefully the relevant doc section https://docs.reown.com/appkit/flutter/core/email
      // You can delete this commented section if you don't want to enable Email/Social login
      featuresConfig: FeaturesConfig(
        email: false,
        // socials: [
        //   AppKitSocialOption.X,
        //   AppKitSocialOption.Apple,
        //   AppKitSocialOption.Discord,
        //   AppKitSocialOption.Farcaster,
        // ],
        showMainWallets: true,
      ),
    );

    appKitModal.init().then((value) => setState(() {}));

    // More events at https://docs.reown.com/appkit/flutter/core/events
    appKitModal.onModalConnect.subscribe(_onModalConnect);
    appKitModal.onModalDisconnect.subscribe(_onModalDisconnect);
  }

  void _onModalConnect(ModalConnect? event) {
    setState(() {});
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    setState(() {});
  }
}
