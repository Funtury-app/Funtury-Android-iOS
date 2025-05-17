import 'package:web3dart/credentials.dart';

class YesNoTransaction {
  final EthereumAddress from;
  final EthereumAddress to;
  final int amount;
  final double totalCost;
  final DateTime timestamp;
  final double perPrice;

  const YesNoTransaction({
    required this.from,
    required this.to,
    required this.amount,
    required this.totalCost,
    required this.timestamp,
    required this.perPrice,
  });

  factory YesNoTransaction.fromData(Map<String, dynamic> data) {
    return YesNoTransaction(
      from: data['from'] as EthereumAddress,
      to: data['to'] as EthereumAddress,
      amount: (data['amount'] as BigInt).toInt(),
      totalCost:
          ((data['totalCost'] as BigInt) / BigInt.from(10).pow(18)).toDouble(),
      timestamp: data['timestamp'] as DateTime,
      perPrice:
          ((data['totalCost'] as BigInt) / BigInt.from(10).pow(18)).toDouble() /
              (data['amount'] as BigInt).toInt(),
    );
  }
}
