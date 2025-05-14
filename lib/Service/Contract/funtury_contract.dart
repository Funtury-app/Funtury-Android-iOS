import 'dart:convert';
import 'package:funtury/Service/Contract/contract_abi_json.dart';
import 'package:web3dart/web3dart.dart';

class FunturyContract {
  static DeployedContract funturyContract = DeployedContract(
    ContractAbi.fromJson(
        jsonEncode(ContractAbiJson.funturyContractAbi), 'FunturyContract'),
    EthereumAddress.fromHex("0x46990239349c59Cf82aA140a9A18c063e3097706"),
  );
  static EthereumAddress contractAddress = EthereumAddress.fromHex("0x46990239349c59Cf82aA140a9A18c063e3097706");

  // Main contract functions
  static ContractFunction claimFreeTokens = funturyContract.function('claimFreeTokens');
  static ContractFunction createMarket = funturyContract.function("createMarket");
  static ContractFunction getMarketCount = funturyContract.function("getMarketCount");
  static ContractFunction getAllMarkets = funturyContract.function("getAllMarkets");
  static ContractFunction getMarketContract = funturyContract.function("getMarketContract");
  static ContractFunction isMarketContract = funturyContract.function("isMarketContract");
  
  // Token management functions
  static ContractFunction transferFromUser = funturyContract.function("transferFromUser");
  static ContractFunction transferReward = funturyContract.function("transferReward");
  static ContractFunction transferBetweenUser = funturyContract.function("transferBetweenUser");
  
  // Admin functions
  static ContractFunction setFreeTokenAmount = funturyContract.function("setFreeTokenAmount");
  static ContractFunction mint = funturyContract.function("mint");
  static ContractFunction resolveMarket = funturyContract.function("resolveMarket");
  static ContractFunction cancelMarket = funturyContract.function("cancelMarket");
  static ContractFunction getBalance = funturyContract.function("balanceOf");
  
  // Contract state reading functions
  static ContractFunction owner = funturyContract.function("owner");
  static ContractFunction freeTokenAmount = funturyContract.function("freeTokenAmount");
  static ContractFunction hasClaimedFreeTokens = funturyContract.function("hasClaimedFreeTokens");
  static ContractFunction totalFTSupply = funturyContract.function("totalFTSupply");
  
  // Events
  static ContractEvent tokensClaimed = funturyContract.event('TokensClaimed');
  static ContractEvent marketCreated = funturyContract.event('MarketCreated');
  static ContractEvent freeTokenAmountChanged = funturyContract.event('FreeTokenAmountChanged');
  
  // Event stream getters
  static Stream<TokensClaimedEvent> getTokensClaimedEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: funturyContract,event: tokensClaimed))
        .map((event) => TokensClaimedEvent.fromEventLog(event));
  }
  
  static Stream<MarketCreatedEvent> getMarketCreatedEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: funturyContract, event: marketCreated))
        .map((event) => MarketCreatedEvent.fromEventLog(event));
  }
  
  static Stream<FreeTokenAmountChangedEvent> getFreeTokenAmountChangedEvents(Web3Client client) {
    return client
        .events(FilterOptions.events(contract: funturyContract, event: freeTokenAmountChanged))
        .map((event) => FreeTokenAmountChangedEvent.fromEventLog(event));
  }
}

// Event models to parse event data
class TokensClaimedEvent {
  final EthereumAddress user;
  final BigInt amount;
  
  TokensClaimedEvent(this.user, this.amount);
  
  static TokensClaimedEvent fromEventLog(FilterEvent event) {
    final decodedData = FunturyContract.tokensClaimed.decodeResults(event.topics!, event.data!);
  
    final userAddress = decodedData[0] as EthereumAddress;
    final amount = decodedData[1] as BigInt;
    
    return TokensClaimedEvent(userAddress, amount);
  }
}

class MarketCreatedEvent {
  final String title;
  final EthereumAddress marketContract;
  final DateTime createTime;
  final DateTime resolutionTime;
  final DateTime preOrderTime;
  
  MarketCreatedEvent(this.title, this.createTime, this.marketContract, this.resolutionTime, this.preOrderTime);
  
  static MarketCreatedEvent fromEventLog(FilterEvent event) {
    final decodedData = FunturyContract.marketCreated.decodeResults(event.topics!, event.data!);
    
    final createTime = DateTime.fromMillisecondsSinceEpoch((decodedData[2] as BigInt).toInt() * 1000);
    final marketContract = decodedData[0] as EthereumAddress;
    final title = decodedData[1] as String;
    final resolutionTime = DateTime.fromMillisecondsSinceEpoch((decodedData[3] as BigInt).toInt() * 1000);
    final preOrderTime = DateTime.fromMillisecondsSinceEpoch((decodedData[4] as BigInt).toInt() * 1000);
    
    return MarketCreatedEvent(title, createTime, marketContract, resolutionTime, preOrderTime);
  }
}

class FreeTokenAmountChangedEvent {
  final BigInt newAmount;
  
  FreeTokenAmountChangedEvent(this.newAmount);
  
  static FreeTokenAmountChangedEvent fromEventLog(FilterEvent event) {
    final decodedData = FunturyContract.freeTokenAmountChanged.decodeResults(event.topics!, event.data!);
    
    final amount = decodedData[0] as BigInt;
    
    return FreeTokenAmountChangedEvent(amount);
  }
}