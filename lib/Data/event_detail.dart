import 'package:web3dart/credentials.dart';

class EventDetail {
  late BigInt? marketCid;
  late String? title;
  final DateTime createTime;
  final DateTime resolutionTime;
  final DateTime preOrderTime;
  final EthereumAddress funturyContract;
  final EthereumAddress owner;
  final MarketState marketState;
  final bool resolvedToYes;
  final int remainYesShares;
  final int reaminNoShares;
  final double initialPrice;

  EventDetail({
    this.title,
    this.marketCid,
    required this.createTime,
    required this.resolutionTime,
    required this.preOrderTime,
    required this.marketState,
    required this.funturyContract,
    required this.owner,
    required this.resolvedToYes,
    required this.remainYesShares,
    required this.reaminNoShares,
    required this.initialPrice,
  });

  factory EventDetail.initFromData(dynamic data) {
    return EventDetail(
      title: data['title'] as String?,
      marketCid: data['marketCid'] as BigInt?,
      createTime: DateTime.fromMillisecondsSinceEpoch(
          (data['createTime'] as BigInt).toInt() * 1000),
      resolutionTime: DateTime.fromMillisecondsSinceEpoch(
          (data['resolutionTime'] as BigInt).toInt() * 1000),
      preOrderTime: DateTime.fromMillisecondsSinceEpoch(
          (data['preOrderTime'] as BigInt).toInt() * 1000),
      marketState: MarketState.values[data['marketState'] as int],
      funturyContract: data['funturyContract'] as EthereumAddress,
      owner: data['owner'] as EthereumAddress,
      resolvedToYes: data['resolvedToYes'] as bool,
      remainYesShares: (data['remainYesShares'] as BigInt).toInt(),
      reaminNoShares: (data['remainNoShares'] as BigInt).toInt(),
      initialPrice: (data['initialPrice'] as BigInt).toDouble() /
          1e18, // Assuming the price is in wei
    );
  }

  factory EventDetail.initFromDefault() {
    return EventDetail(
        title: "Market Title",
        createTime: DateTime.now(),
        resolutionTime: DateTime.now().add(Duration(days: 2)),
        preOrderTime: DateTime.now().add(Duration(days: 1)),
        marketState: MarketState.preorder,
        funturyContract: EthereumAddress.fromHex("0x41AC577c21C98e0CDF596576A81f0fE7FCa3bd06"),
        owner: EthereumAddress.fromHex("0x41AC577c21C98e0CDF596576A81f0fE7FCa3bd06"),
        resolvedToYes: false,
        remainYesShares: 1000,
        reaminNoShares: 1000,
        initialPrice: 0.5);
  }
}

enum MarketState {
  preorder(stateCode: 0),
  active(stateCode: 1),
  resolved(stateCode: 2),
  cancelled(stateCode: 3);

  final int stateCode;
  const MarketState({required this.stateCode});
}
