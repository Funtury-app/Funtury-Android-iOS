import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ReownService {
  static ReownService? service;

  late BuildContext context;
  late void Function(VoidCallback) setState;

  static const String baseUrl = 'https://rewon.com/api/v1';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getUserProfile = '$baseUrl/user/profile';
  static const String updateUserProfile = '$baseUrl/user/update-profile';
  static const String getUserPosts = '$baseUrl/user/posts';
  static const String createPost = '$baseUrl/posts/create';
  static const String updatePost = '$baseUrl/posts/update';
  static const String deletePost = '$baseUrl/posts/delete';
  static const String likePost = '$baseUrl/posts/like';
  static const String commentOnPost = '$baseUrl/posts/comment';
  static const String getComments = '$baseUrl/posts/comments';
  static const String getNotifications = '$baseUrl/notifications';
  static const String markNotificationAsRead = '$baseUrl/notifications/read';
  // Add more endpoints as needed

  late ReownAppKitModal? appKitModal;

  ReownService({
    required this.context,
    required this.setState,
  });

  factory ReownService.create(
      BuildContext context, void Function(VoidCallback) setState) {
    
    // ReownAppKitModalNetworks.addSupportedNetworks(NetworkUtils.eip155, [
    //   ReownAppKitModalNetworkInfo(
    //       name: "Funtury",
    //       chainId: "1337",
    //       currency: 'ETH',
    //       rpcUrl: "https://6722-2001-b400-e174-69a3-a8c8-9e7-ed38-ed46.ngrok-free.app",
    //       explorerUrl: "https://6722-2001-b400-e174-69a3-a8c8-9e7-ed38-ed46.ngrok-free.app",)]);
    
    ReownService temp = ReownService(context: context, setState: setState);
    temp.appKitModal = ReownAppKitModal(
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
      featuredWalletIds: {},
      includedWalletIds: {
        'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96',
      },
      excludedWalletIds: {},
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
    return temp;
  }

  Future init() async {
    if (appKitModal!.status != ReownAppKitModalStatus.initialized) {
      await appKitModal!.init().then((value) => setState(() {}));
    }

    // More events at https://docs.reown.com/appkit/flutter/core/events
    appKitModal!.onModalConnect.subscribe(_onModalConnect);
    appKitModal!.onModalDisconnect.subscribe(_onModalDisconnect);
  }

  void _onModalConnect(ModalConnect? event) {
    if (!context.mounted) return;
    setState(() {});
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    if (!context.mounted) return;
    setState(() {});
  }

  void dispose() {
    appKitModal!.onModalConnect.unsubscribe(_onModalConnect);
    appKitModal!.onModalDisconnect.unsubscribe(_onModalDisconnect);
    appKitModal!.dispose();
    service = null;
  }
}
