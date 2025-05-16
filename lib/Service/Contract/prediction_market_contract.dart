import 'dart:convert';
import 'package:funtury/Service/Contract/contract_abi_json.dart';
import 'package:web3dart/web3dart.dart';

class PredictionMarketContract {
  DeployedContract createContract(EthereumAddress contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(
          jsonEncode(ContractAbiJson.predictionMarketContractAbi),
          'PredictionMarket'),
      contractAddress,
    );
  }

  late DeployedContract contract;
  late EthereumAddress contractAddress;

  PredictionMarketContract({required this.contractAddress}) {
    contract = createContract(contractAddress);
  }

  // Basic market information
  ContractFunction title() => contract.function("title");
  ContractFunction owner() => contract.function("owner");
  ContractFunction createTime() => contract.function("createTime");
  ContractFunction resolutionTime() => contract.function("resolutionTime");
  ContractFunction preOrderTime() => contract.function("preOrderTime");
  ContractFunction funturyContract() => contract.function("funturyContract");
  ContractFunction getMarketInfo() => contract.function("getMarketInfo");

  // Market state functions
  ContractFunction state() => contract.function("state");
  ContractFunction getMarketState() => contract.function("getMarketState");
  ContractFunction resolvedToYes() => contract.function("resolvedToYes");

  // Price and shares functions
  ContractFunction initialPrice() => contract.function("initialPrice");
  ContractFunction getInitialPrice() => contract.function("getInitialPrice");
  ContractFunction initialYesShares() => contract.function("initialYesShares");
  ContractFunction initialNoShares() => contract.function("initialNoShares");
  ContractFunction initialYesProbability() => contract.function("initialYesProbability");
  ContractFunction initialNoProbability() => contract.function("initialNoProbability");
  ContractFunction marketRemainYesShares() => contract.function("marketRemainYesShares");
  ContractFunction marketRemainNoShares() => contract.function("marketRemainNoShares");
  ContractFunction getMarketInitialYesNoShares() => contract.function("getMarketInitialYesNoShares");
  ContractFunction getMarketRemainYesNoShares() => contract.function("getMarketRemainYesNoShares");

  // User-related functions
  ContractFunction getUserShares() => contract.function("getUserShares");
  ContractFunction userYesTokens() => contract.function("userYesTokens");
  ContractFunction userNoTokens() => contract.function("userNoTokens");
  ContractFunction hasClaimedReward() => contract.function("hasClaimedReward");
  ContractFunction checkReward() => contract.function("checkReward");

  // Action functions
  ContractFunction checkAndEndPreorder() => contract.function("checkAndEndPreorder");
  ContractFunction transferShares() => contract.function("transferShares");
  ContractFunction preOrderTransfer() => contract.function("preOrderTransfer");
  ContractFunction resolveMarket() => contract.function("resolveMarket");
  ContractFunction cancelMarket() => contract.function("cancelMarket");
  ContractFunction claimReward() => contract.function("claimReward");

  // Events
  ContractEvent marketResolved() => contract.event('MarketResolved');
  ContractEvent marketCancelled() => contract.event('MarketCancelled');
  ContractEvent yesTransaction() => contract.event('YesTransaction');
  ContractEvent noTransaction() => contract.event('NoTransaction');
  ContractEvent rewardClaimed() => contract.event('RewardClaimed');

  // Event stream getters
  Stream<MarketResolvedEvent> getMarketResolvedEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: contract, event: marketResolved()))
        .map((event) => MarketResolvedEvent.fromEventLog(this, event));
  }

  Stream<MarketCancelledEvent> getMarketCancelledEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: contract, event: marketCancelled()))
        .map((event) => MarketCancelledEvent.fromEventLog(this, event));
  }

  Stream<YesTransactionEvent> getYesTransactionEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: contract, event: yesTransaction()))
        .map((event) => YesTransactionEvent.fromEventLog(this, event));
  }

  Stream<NoTransactionEvent> getNoTransactionEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: contract, event: noTransaction()))
        .map((event) => NoTransactionEvent.fromEventLog(this, event));
  }

  Stream<RewardClaimedEvent> getRewardClaimedEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: contract, event: rewardClaimed()))
        .map((event) => RewardClaimedEvent.fromEventLog(this, event));
  }
}

// Event models to parse event data
class MarketResolvedEvent {
  final EthereumAddress market;
  final bool resolvedToYes;

  MarketResolvedEvent(this.market, this.resolvedToYes);

  static MarketResolvedEvent fromEventLog(
      PredictionMarketContract contractInstance, FilterEvent event) {
    final decodedData = contractInstance
        .marketResolved()
        .decodeResults(event.topics!, event.data!);

    final market = decodedData[0] as EthereumAddress;
    final resolvedToYes = decodedData[1] as bool;

    return MarketResolvedEvent(market, resolvedToYes);
  }
}

class MarketCancelledEvent {
  final EthereumAddress market;

  MarketCancelledEvent(this.market);

  static MarketCancelledEvent fromEventLog(
      PredictionMarketContract contractInstance, FilterEvent event) {
    final decodedData = contractInstance
        .marketCancelled()
        .decodeResults(event.topics!, event.data!);

    final market = decodedData[0] as EthereumAddress;

    return MarketCancelledEvent(market);
  }
}

class YesTransactionEvent {
  final EthereumAddress from;
  final EthereumAddress to;
  final BigInt amount;
  final BigInt totalCost;

  YesTransactionEvent(this.from, this.to, this.amount, this.totalCost);

  static YesTransactionEvent fromEventLog(
      PredictionMarketContract contractInstance, FilterEvent event) {
    final decodedData = contractInstance
        .yesTransaction()
        .decodeResults(event.topics!, event.data!);

    final from = decodedData[0] as EthereumAddress;
    final to = decodedData[1] as EthereumAddress;
    final amount = decodedData[2] as BigInt;
    final totalCost = decodedData[3] as BigInt;

    return YesTransactionEvent(from, to, amount, totalCost);
  }
}

class NoTransactionEvent {
  final EthereumAddress from;
  final EthereumAddress to;
  final BigInt amount;
  final BigInt totalCost;

  NoTransactionEvent(this.from, this.to, this.amount, this.totalCost);

  static NoTransactionEvent fromEventLog(
      PredictionMarketContract contractInstance, FilterEvent event) {
    final decodedData = contractInstance
        .noTransaction()
        .decodeResults(event.topics!, event.data!);

    final from = decodedData[0] as EthereumAddress;
    final to = decodedData[1] as EthereumAddress;
    final amount = decodedData[2] as BigInt;
    final totalCost = decodedData[3] as BigInt;

    return NoTransactionEvent(from, to, amount, totalCost);
  }
}

class RewardClaimedEvent {
  final EthereumAddress user;
  final EthereumAddress market;
  final BigInt amount;

  RewardClaimedEvent(this.user, this.market, this.amount);

  static RewardClaimedEvent fromEventLog(
      PredictionMarketContract contractInstance, FilterEvent event) {
    final decodedData = contractInstance
        .rewardClaimed()
        .decodeResults(event.topics!, event.data!);

    final user = decodedData[0] as EthereumAddress;
    final market = decodedData[1] as EthereumAddress;
    final amount = decodedData[2] as BigInt;

    return RewardClaimedEvent(user, market, amount);
  }
}