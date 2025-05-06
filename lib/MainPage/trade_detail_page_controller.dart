import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/segmented_control.dart';
import 'package:reown_appkit/reown_appkit.dart';

class TradeDetailPageController {
  TradeDetailPageController(
      {required this.context,
      required this.setState,
      required this.marketAddress});

  late BuildContext context;
  late void Function(VoidCallback) setState;
  late EthereumAddress marketAddress;


  bool isYesDiagram = true;
  bool isBuyingPosition = true;
  bool isYesPosition = true;
  bool marketInfoLoading = false;


  Future<void> init() async{
    setState((){
      marketInfoLoading = true;
    });

    


    setState((){
      marketInfoLoading = false;
    });
  }

  void switchDiagram(SegmentOption option){
    setState((){
      isYesDiagram = option == SegmentOption.option1;
    });
  }

  void switchPosition(SegmentOption option){
    setState((){
      isBuyingPosition = option == SegmentOption.option1;
    });
  }

  void switchYesNoPosition(bool isYes){
    setState((){
      isYesPosition = isYes;
    });
  }
}
