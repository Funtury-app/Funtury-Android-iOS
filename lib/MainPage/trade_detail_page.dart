import 'package:flutter/material.dart';
import 'package:funtury/MainPage/trade_detail_page_controller.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/segmented_control.dart';
import 'package:reown_appkit/reown_appkit.dart';

class TradeDetailPage extends StatefulWidget {
  const TradeDetailPage({super.key, required this.marketAddress});

  final EthereumAddress marketAddress;

  @override
  State<TradeDetailPage> createState() => _TradeDetailPageState();
}

class _TradeDetailPageState extends State<TradeDetailPage> {
  late TradeDetailPageController tradeDetailPageController;

  @override
  void initState() {
    super.initState();
    tradeDetailPageController = TradeDetailPageController(
      context: context,
      setState: setState,
      marketAddress: widget.marketAddress,
    );
    tradeDetailPageController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Color(0XFFFFE797),
              Colors.white,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.37, 0.71, 1.0]),
      ),
      child: FittedBox(
          fit: BoxFit.fill,
          child: SizedBox(
            width: 393,
            height: 852,
            child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Color(0XFFFFE797),
                    Colors.white,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.37, 0.71, 1.0],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Icon(Icons.image,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        Text(
                          widget.marketAddress.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 345,
                      height: 313,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          // Yes No diagram switcher
                          SegmentedControl(
                            width: 200,
                            onChange: (option) =>
                                tradeDetailPageController.switchDiagram(option),
                            option1Title: "YES",
                            option2Title: "No",
                          ),
                          Expanded(
                              child: Container(
                            color: Colors.blue,
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 345,
                      height: 340,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Colors.white.withOpacity(0.11),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Buy Sell position button
                          SegmentedControl(
                            width: 200,
                            onChange: (option) => tradeDetailPageController
                                .switchPosition(option),
                            option1Title: "Buy",
                            option2Title: "Sell",
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: tradeDetailPageController
                                              .isYesPosition
                                          ? Color(0xFF3CEE2C).withOpacity(0.7)
                                          : Color(0xFF9A9CA1).withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      shadowColor: tradeDetailPageController.isYesPosition ? Colors.black.withOpacity(0.25) : Colors.transparent,
                                    ),
                                    onPressed: () => tradeDetailPageController
                                        .switchYesNoPosition(true),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Text("Yes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                            width: 37,
                                            height: 25,
                                            child: Text(
                                              "${58}F",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ))
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: 120,
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: tradeDetailPageController
                                              .isYesPosition
                                          ? Color(0xFF9A9CA1).withOpacity(0.8)
                                          : Color(0xFFEE2C2C).withOpacity(0.7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      shadowColor: tradeDetailPageController.isYesPosition ? Colors.transparent : Colors.black.withOpacity(0.25),
                                    ),
                                    onPressed: () => tradeDetailPageController
                                        .switchYesNoPosition(false),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Text("No",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                            width: 37,
                                            height: 25,
                                            child: Text(
                                              "${58}F",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ))
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
