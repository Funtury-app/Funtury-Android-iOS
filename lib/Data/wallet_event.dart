import 'package:reown_appkit/reown_appkit.dart';

class WalletEvent {
  String title;
  EthereumAddress marketAddress;
  DateTime createTime;
  DateTime resolutionTime;
  DateTime preOrderTime;
  int? yesShares;
  int? noShares;

  WalletEvent({
    required this.title,
    required this.createTime,
    required this.resolutionTime,
    required this.preOrderTime,
    required this.marketAddress,
  });

  factory WalletEvent.fromData(Map<String, dynamic> data) {
    return WalletEvent(
      title: data['title'] as String,
      createTime: data['createTime'] as DateTime,
      preOrderTime: data['preOrderTime'] as DateTime,
      resolutionTime: data['resolutionTime'] as DateTime,
      marketAddress: data['marketContract'] as EthereumAddress,
    );
  }
}