import 'package:flutter/material.dart';
import 'package:funtury/MainPage/ranking_page_controller.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  late RankingPageController rankingPageController;

  @override
  void initState() {
    super.initState();
    rankingPageController = RankingPageController(
      context: context,
      setState: setState,
      rankScroll: ScrollController(),
    );
    rankingPageController.init();
    rankingPageController.rankScroll.addListener(() {
      if (rankingPageController.rankScroll.position.pixels <= 0) {
        rankingPageController.setState(() {
          rankingPageController.showScrollToTopButton = false;
        });
      } else {
        rankingPageController.setState(() {
          rankingPageController.showScrollToTopButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    rankingPageController.rankScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
            padding: const EdgeInsets.only(top: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Funtury Leader Board",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  // Leader Board
                  SizedBox(
                      width: 360,
                      height: 546,
                      child: Stack(
                        children: [
                          RefreshIndicator(
                            backgroundColor: Colors.transparent,
                            onRefresh: rankingPageController.init,
                            child: ListView(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              controller: rankingPageController.rankScroll,
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                for (int i = 0;
                                    i < rankingPageController.userList.length;
                                    i++) ...[
                                  RankingCard(
                                    place: i + 1,
                                    userinfo: rankingPageController.userList[i],
                                  ),
                                ],
                                if (rankingPageController.isLoading)
                                  const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (rankingPageController.showScrollToTopButton)
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Opacity(
                                  opacity: 0.85,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_upward,
                                        color: Colors.white,
                                      ),
                                      onPressed:
                                          rankingPageController.scrollToTop,
                                    ),
                                  )),
                            )
                        ],
                      )),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (rankingPageController.isLoading)
                    Container(
                      height: 70,
                      width: 380,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),

                  if (!rankingPageController.isLoading)
                    RankingCard(
                        place: rankingPageController.selfPlace,
                        userinfo: rankingPageController.selfInfo)
                ])));
  }
}

class RankingCard extends StatelessWidget {
  const RankingCard({super.key, required this.place, required this.userinfo});

  final int place;
  final User userinfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 380,
      decoration: BoxDecoration(
        color: userinfo.self
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          // User Place
          Container(
            height: 70,
            width: 73,
            alignment: Alignment.center,
            child: Text(
              place.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),

          // User info
          Container(
            height: 70,
            width: 185,
            alignment: Alignment.center,
            child: Text(
              userinfo.userAddress.hex,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),

          // User Balance
          Container(
              height: 70,
              width: 68,
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  userinfo.userBalance.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                ),
              )),

          // Funtury token
          Container(
            height: 70,
            width: 33,
            alignment: Alignment.center,
            child: Text(
              "𝟊",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
