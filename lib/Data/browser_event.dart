import 'package:web3dart/credentials.dart';

class BrowserEvent {
  String title;
  EthereumAddress marketAddress;
  DateTime createTime;
  DateTime resolutionTime;
  DateTime preOrderTime;
  int yesProbability;
  int noProbability;
  late double yesnoRatio;

  BrowserEvent({
    required this.title,
    required this.createTime,
    required this.preOrderTime,
    required this.resolutionTime,
    required this.marketAddress,
    required this.yesProbability,
    required this.noProbability,
  }) {
    yesnoRatio = yesProbability / (yesProbability + noProbability);
  }

  factory BrowserEvent.fromData(Map<String, dynamic> data) {
    return BrowserEvent(
      title: data['title'] as String,
      createTime: data['createTime'] as DateTime,
      preOrderTime: data['preOrderTime'] as DateTime,
      resolutionTime: data['resolutionTime'] as DateTime,
      marketAddress: data['marketContract'] as EthereumAddress,
      yesProbability: ((data['yesProbability'] as double) * 100).toInt(),
      noProbability: ((data['noProbability'] as double) * 100).toInt(),
    );
  }
}
