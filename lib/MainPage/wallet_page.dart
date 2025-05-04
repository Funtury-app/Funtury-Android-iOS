import 'package:flutter/material.dart';
import 'package:funtury/MainPage/wallet_page_controller.dart';
import 'package:reown_appkit/reown_appkit.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late WalletPageController walletPageController;

  @override
  initState() {
    super.initState();
    walletPageController = WalletPageController(
      context: context,
      setState: setState,
    );
    walletPageController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Wallet",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.history,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.black,
                                  ))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: walletPageController.balanceLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Balance\nF ${walletPageController.balance.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 220,
                          height: 38,
                          child: walletPageController.claimedLoading
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                              : ElevatedButton(
                                  onPressed: walletPageController.alreadyClaimed
                                      ? () {}
                                      : walletPageController.claimedFreeToken,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          walletPageController.alreadyClaimed
                                              ? Colors.grey
                                              : Colors.orangeAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: walletPageController.alreadyClaimed
                                      ? Text(
                                          "Free Tokens Has Claimed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "Claim Free Tokens",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Stocks",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                          child: walletPageController.positionLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : walletPageController.userPosition.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Empty",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemBuilder: (_, index) {
                                        final marketAddress =
                                            walletPageController
                                                .userPosition.keys
                                                .toList()[index];
                                        final position = walletPageController
                                            .userPosition[marketAddress]!;
                                        return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: PositionCard(
                                              marketAddress: marketAddress,
                                              yesPosition:
                                                  position.$1.toDouble(),
                                              noPosition:
                                                  position.$2.toDouble(),
                                            ));
                                      },
                                      itemCount: walletPageController
                                          .userPosition.length))
                    ]))));
  }
}

class PositionCard extends StatefulWidget {
  const PositionCard(
      {super.key,
      required this.marketAddress,
      required this.yesPosition,
      required this.noPosition});

  final EthereumAddress marketAddress;
  final double yesPosition;
  final double noPosition;

  @override
  State<PositionCard> createState() => _PositionCardState();
}

class _PositionCardState extends State<PositionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      height: 90,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 197,
            child: Text(
              widget.marketAddress.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.only(right: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 25,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.yesPosition.toStringAsFixed(0),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.only(right: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      "No",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                    SizedBox(
                    width: 40,
                    height: 25,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.noPosition.toStringAsFixed(0),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
