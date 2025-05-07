// import 'package:flutter/material.dart';
// import 'package:reown_appkit/reown_appkit.dart';
// import 'package:url_launcher/url_launcher.dart';

// class WalletService extends ChangeNotifier {
//   ReownAppKit? _appKit;
//   ReownAppKitModal? _appKitModal;
//   String? _accountAddress;
//   int? _chainId;

//   String get accountAddress => _accountAddress ?? '';
//   bool get isConnected => _accountAddress != null;

//   Future<void> init(BuildContext context) async {
//     _appKit = await ReownAppKit.createInstance(
//       projectId:
//           '36e52185ba38144b6468153c77ef73ac', // Replace with your project ID
//       metadata: const PairingMetadata(
//         name: 'Funtury',
//         description: 'A blockchain prediction market application',
//         url: 'https://funtury.com',
//         icons: ['https://funtury.com/logo.png'],
//         redirect: Redirect(
//           native: 'metamaskreownganache://',
//           universal: 'https://funtury.com',
//         ),
        
//       ),
      
//     );

//     if (context.mounted) {
//       _appKitModal = ReownAppKitModal(
//         context: context,
//         appKit: _appKit!,
//       );
//     }

//     // Register event handlers
//     _appKit!.onSessionConnect.subscribe((session) {
//       _accountAddress = session?.sessionData?.accounts?.first;
//       _chainId = session?.sessionData?.chainId;
//       notifyListeners();
//     });

//     _appKit!.onSessionDisconnect.subscribe((_) {
//       _accountAddress = null;
//       _chainId = null;
//       notifyListeners();
//     });

//     await _appKitModal!.init();
//   }

//   Future<void> connectWallet() async {
//     if (!_appKit!.isConnected) {
//       await _appKitModal!.open();
//     }
//   }

//   Future<void> disconnectWallet() async {
//     await _appKit!.disconnect();
//   }
// }
