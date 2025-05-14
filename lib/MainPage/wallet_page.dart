import 'package:flutter/material.dart';
import 'package:funtury/Data/wallet_event.dart';
import 'package:funtury/MainPage/wallet_page_controller.dart';
import 'package:funtury/route_map.dart';

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
                                        return PositionCard(
                                          event: walletPageController
                                              .userPosition[index],
                                          walletPageController: walletPageController,
                                        );
                                      },
                                      itemCount: walletPageController
                                          .userPosition.length))
                    ]))));
  }
}

class PositionCard extends StatefulWidget {
  const PositionCard({super.key, required this.event, required this.walletPageController});

  final WalletEvent event;
  final WalletPageController walletPageController;

  @override
  State<PositionCard> createState() => _PositionCardState();
}

class _PositionCardState extends State<PositionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final int? addBalance = await Navigator.of(context)
            .pushNamed(RouteMap.tradeDetailPage, arguments: (widget.event.marketAddress, widget.event.yesShares, widget.event.noShares));
        if(addBalance != null){
          widget.walletPageController.updateBalance(widget.walletPageController.balance + addBalance);
        }
      },
      child: Container(
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
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Preorder Time: ${widget.event.preOrderTime.year}.${widget.event.preOrderTime.month}.${widget.event.preOrderTime.day}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Resolve Time: ${widget.event.resolutionTime.year}.${widget.event.resolutionTime.month}.${widget.event.resolutionTime.day}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                )),
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
                          widget.event.yesShares.toString(),
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
                          widget.event.noShares.toString(),
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
      ),
    );
  }
}
