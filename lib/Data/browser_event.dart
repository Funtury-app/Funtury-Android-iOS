import 'package:reown_appkit/reown_appkit.dart';

class BrowserEvent {
  EthereumAddress marketAddress;
  int yesProbability;
  int noProbability;
  late double yesnoRatio;

  BrowserEvent({
    required this.marketAddress,
    required this.yesProbability,
    required this.noProbability,
  }){
    yesnoRatio = yesProbability / (yesProbability + noProbability);
  }

  factory BrowserEvent.fromData(dynamic data){
    return BrowserEvent(
      marketAddress: data['marketAddress'] as EthereumAddress,
      yesProbability: data['yesProbability'] as int,
      noProbability: data['noProbability'] as int,
    );
  }
}