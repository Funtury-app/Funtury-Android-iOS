// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funtury/Service/Contract/Funtury_contract.dart';
import 'package:funtury/Service/Contract/prediction_market_contract.dart';
// import 'package:funtury/Service/Contract/contract_abi_json.dart';
// import 'package:funtury/Service/Contract/contract_address.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
// import 'package:reown_appkit/solana/solana_common/src/converters/hex_codec.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bip32/bip32.dart' as bip32;
// import 'package:bip39/bip39.dart' as bip39;

class GanacheService {
  static const String _rpcUrl = "https://cab0-120-126-194-245.ngrok-free.app";
  static final EthPrivateKey _privateKey = EthPrivateKey.fromHex(
      "0x5a6e7d345770f89593791ea4aab8882dd2e8c3ca6e3219d5c4a82de775f0341a");
  static final EthereumAddress userAddress =
      EthereumAddress.fromHex("0x82Be6C4b686dF7908aB0771f18b4e3C134e923FD");

  late Client httpClient;
  late Web3Client ganacheClient;

  GanacheService() {
    httpClient = Client();
    ganacheClient = Web3Client(_rpcUrl, Client());
  }

  // Future<void> transferTo(
  //     EthereumAddress sender, EthereumAddress to, BigInt value) async {
  //   value = value * BigInt.from(10).pow(18);
  //   try {
  //     final tx = await ganacheClient.signTransaction(
  //         _privateKey,
  //         Transaction(
  //           from: _privateKey.address,
  //           gasPrice: EtherAmount.inWei(BigInt.from(20000000000)),
  //           maxGas: 100000,
  //           value: EtherAmount.zero(),
  //           to: _contract.address,
  //           data: _transferTo.encodeCall([to, value]),
  //         ),
  //         chainId: 1337);

  //     final result = await ganacheClient.sendRawTransaction(tx);
  //     debugPrint("GanacheService transferTo result: $result");
  //   } catch (e) {
  //     debugPrint("GanacheService transferTo error: $e");
  //   }

  //   return;
  // }

  /// Funtury contract transfer function ///

  Future<double> getBalance() async {
    try {
      final result = await ganacheClient.call(
          contract: FunturyContract.funturyContract,
          function: FunturyContract.getBalance,
          params: [userAddress]);
      final balance = (result[0] as BigInt) / BigInt.from(10).pow(18);
      debugPrint("GanacheService getBalance result: $balance");
      return balance.toDouble();
    } catch (e) {
      debugPrint("GanacheService getBalance error: $e");
      return 0;
    }
  }

  Future<List<EthereumAddress>> queryAllMarket() async {
    // try {
    //   final filter = FilterOptions(
    //     address: FunturyContract.contractAddress,
    //     topics: [
    //       [
    //         bytesToHex(FunturyContract.marketCreated.signature, include0x: true)
    //       ],
    //     ],
    //     fromBlock: const BlockNum.genesis(),
    //     toBlock: const BlockNum.current(),
    //   );

    //   final logs = await ganacheClient.getLogs(filter);

    //   for (var log in logs) {
    //     final decodedLog = FunturyContract.marketCreated.decodeResults(
    //       log.topics!,
    //       log.data!,
    //     );

    //     debugPrint(decodedLog.toString());
    //   }
    // } catch (e) {
    //   debugPrint("GanacheService queryAllMarket error: $e");
    // }

    try {
      final result = await ganacheClient.call(
          contract: FunturyContract.funturyContract,
          function: FunturyContract.getAllMarkets,
          params: []);
      final markets = List<EthereumAddress>.from(result[0] as List);
      debugPrint("GanacheService getAllMarkets result: $markets");
      return markets;
    } catch (e) {
      debugPrint("GanacheService getAllMarkets error: $e");
      return [];
    }
  }

  Future<void> claimedFreeToken() async {
    try {
      final tx = await ganacheClient.signTransaction(
          _privateKey,
          Transaction(
            from: _privateKey.address,
            gasPrice: EtherAmount.inWei(BigInt.from(20000000000)),
            maxGas: 100000,
            value: EtherAmount.zero(),
            to: FunturyContract.contractAddress,
            data: FunturyContract.claimFreeTokens.encodeCall([]),
          ),
          chainId: 1337);

      final result = await ganacheClient.sendRawTransaction(tx);
      debugPrint("GanacheService transferTo result: $result");
    } catch (e) {
      debugPrint("GanacheService transferTo error: $e");
    }
  }

  Future<bool> checkFreeTokenClaimed() async {
    try {
      final result = await ganacheClient.call(
          contract: FunturyContract.funturyContract,
          function: FunturyContract.hasClaimedFreeTokens,
          params: [userAddress]);
      debugPrint("GanacheService checkFreeTokenClaimed result: $result");
      return result[0];
    } catch (e) {
      debugPrint("GanacheService checkFreeTokenClaimed error: $e");
      return false;
    }
  }

  /// Funtury contract transfer function ///

  /// Prediction contract transfer function ///

  Future<(double, double)> getUserPosition(EthereumAddress marketAddress) async {
    PredictionMarketContract predictionMarketContract =
        PredictionMarketContract(contractAddress: marketAddress);

    try{
      
      final result = await ganacheClient.call(
          contract: predictionMarketContract.contract,
          function: predictionMarketContract.getUserShares(),
          params: [userAddress]);
      debugPrint("GanacheService getUserPosition result: $result");
      
      return ((result[0] as BigInt).toDouble(), (result[1] as BigInt).toDouble());
    } catch(e){
      debugPrint("GanacheService getUserPosition error: $e");
      return (0.0, 0.0);
    }
  }

  /// Prediction contract transfer function ///
}

  // Future<void> getPrivateKey() async {
  //   try {
  //     final sp = await SharedPreferences.getInstance();
  //     final mnemonic = sp.getString("mnemonic") ?? bip39.generateMnemonic();
  //     if (!sp.containsKey('mnemonic')) {
  //       await sp.setString('mnemonic', mnemonic);
  //     }
  //     final seed = bip39.mnemonicToSeed(mnemonic);
  //     final wallet = bip32.BIP32.fromSeed(seed);
  //     final pathWallet = wallet.derivePath("m/44'/60'/0'/0");
  //     _privateKey = EthPrivateKey.fromHex(hexEncode(pathWallet.privateKey!));
  //     debugPrint("GanacheService getPrivateKey result: $_privateKey");
  //   } catch (e) {
  //     debugPrint("GanacheService getPrivateKey error: $e");
  //   }
  //   return;
  // }

  // btcWallet = hdWallet.derivePath("m/44'/0'/0'/0/0");
  // ethWallet = hdWallet.derivePath("m/44'/60'/0'/0/0");
  // tronWallet = hdWallet.derivePath("m/44'/195'/0'/0/0");
  // solanaWallet = hdWallet.derivePath("m/44'/501'/0'/0/0");
  // bnbWallet = hdWallet.derivePath("m/44'/714'/0'/0/0");
  // dogeWallet = hdWallet.derivePath("m/44'/3'/0'/0/0");
  // avaxWallet = hdWallet.derivePath("m/44'/60'/0'/0/0");
  // aptosWallet = hdWallet.derivePath("m/44'/637'/0'/0/0");
  // nearWallet = hdWallet.derivePath("m/44'/397'/0'/0/0");
  // solanaWallet = hdWallet.derivePath("m/44'/501'/0'/0/0");
  // zilliqaWallet = hdWallet.derivePath("m/44'/313'/0'/0/0");
  // algorandWallet = hdWallet.derivePath("m/44'/283'/0'/0/0");