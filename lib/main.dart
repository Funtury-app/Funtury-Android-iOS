import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Check out the docs on how to tweak the modal theme https://docs.reown.com/appkit/flutter/core/theming
    return ReownAppKitModalTheme(
      // isDarkMode: false | true,
      // themeData: ReownAppKitModalThemeData(
      //   lightColors: ReownAppKitModalColors.lightMode.copyWith(),
      //   darkColors: ReownAppKitModalColors.darkMode.copyWith(),
      //   radiuses: ReownAppKitModalRadiuses.circular,
      // ),
      child: MaterialApp(
        title: 'funtury',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ReownAppKitModal _appKitModal;

  @override
  void initState() {
    super.initState();
    // TODO check the docs at https://docs.reown.com/appkit/flutter/core/installation

    _appKitModal = ReownAppKitModal(
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
      // If you enable social features you will have to whitelist your bundleId/packageName under the Mobile Application IDs secion in https://cloud.reown.com/app
      // Please also follow carefully the relevant doc section https://docs.reown.com/appkit/flutter/core/email
      // You can delete this commented section if you don't want to enable Email/Social login
      // featuresConfig: FeaturesConfig(
      //   email: true,
      //   socials: [
      //     AppKitSocialOption.X,
      //     AppKitSocialOption.Apple,
      //     AppKitSocialOption.Discord,
      //     AppKitSocialOption.Farcaster,
      //   ],
      // ),
    );

    _appKitModal.init().then((value) => setState(() {}));

    // More events at https://docs.reown.com/appkit/flutter/core/events
    _appKitModal.onModalConnect.subscribe(_onModalConnect);
    _appKitModal.onModalDisconnect.subscribe(_onModalDisconnect);
  }

  void _onModalConnect(ModalConnect? event) {
    setState(() {});
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('funtury'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            AppKitModalNetworkSelectButton(
              appKit: _appKitModal,
              context: context,
            ),
            AppKitModalConnectButton(
              appKit: _appKitModal,
              context: context,
            ),
            Visibility(
              visible: _appKitModal.isConnected,
              child: Column(
                children: [
                  AppKitModalAccountButton(
                    appKitModal: _appKitModal,
                    context: context,
                  ),
                  AppKitModalAddressButton(
                    appKitModal: _appKitModal,
                    onTap: () {},
                  ),
                  AppKitModalBalanceButton(
                    appKitModal: _appKitModal,
                    onTap: () {},
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: _appKitModal.balanceNotifier,
                    builder: (_, balance, __) {
                      return Text('My balance: $balance');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
