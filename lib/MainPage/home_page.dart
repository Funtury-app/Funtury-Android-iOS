import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funtury/MainPage/browser_page.dart';
import 'package:funtury/MainPage/home_page_controller.dart';
import 'package:funtury/MainPage/wallet_page.dart';
import 'package:funtury/assets_path.dart';
import 'package:reown_appkit/modal/pages/public/appkit_modal_all_wallets_page.dart';

class LazyLoadPage extends StatefulWidget {
  final Widget Function() builder;
  final bool shouldBuild;

  const LazyLoadPage({
    super.key,
    required this.builder,
    required this.shouldBuild,
  });

  @override
  State<LazyLoadPage> createState() => _LazyLoadPageState();
}

class _LazyLoadPageState extends State<LazyLoadPage> {
  Widget? _cached;

  @override
  Widget build(BuildContext context) {
    if (!widget.shouldBuild) {
      return Container();
    }

    _cached ??= widget.builder();
    return _cached!;
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late HomePageController homePageController;

  @override
  void initState() {
    super.initState();
    homePageController =
        HomePageController(context: context, setState: setState);
    homePageController.init();

    homePageController.hasVisited[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: homePageController.currentScreenIndex == 0
                    ? [
                        0,
                        0.28,
                      ]
                    : [
                        0.0,
                        0.0,
                      ],
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Colors.white,
                ],
              ),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                  width: 393,
                  height: 852,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: homePageController.currentScreenIndex == 0
                          ? [
                              0,
                              0.28,
                            ]
                          : [
                              0.0,
                              0.0,
                            ],
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      IndexedStack(
                        alignment: Alignment.center,
                        index: homePageController.currentScreenIndex,
                        children: [
                          LazyLoadPage(
                            shouldBuild: homePageController.hasVisited[0],
                            builder: () => BrowserPage(),
                          ),
                          LazyLoadPage(
                            shouldBuild: homePageController.hasVisited[1],
                            builder: () => Text("News"),
                          ),
                          LazyLoadPage(
                            shouldBuild: homePageController.hasVisited[2],
                            builder: () => const Text('Notifications'),
                          ),
                          LazyLoadPage(
                            shouldBuild: homePageController.hasVisited[3],
                            builder: () => WalletPage(),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 20,
                        child: Container(
                          height: 60,
                          width: 340,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(
                                    color: homePageController
                                                .currentScreenIndex ==
                                            0
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      AssetsPath.homeIcon,
                                      height: 31.11,
                                      width: 35,
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: () => homePageController
                                        .switchScreen(MainScreen.browser),
                                  )),
                              Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(
                                    color: homePageController
                                                .currentScreenIndex ==
                                            1
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      AssetsPath.newsIcon,
                                      height: 35,
                                      width: 35,
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: () => homePageController
                                        .switchScreen(MainScreen.news),
                                  )),
                              Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(
                                    color: homePageController
                                                .currentScreenIndex ==
                                            2
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      AssetsPath.bellIcon,
                                      height: 40,
                                      width: 35,
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: () => homePageController
                                        .switchScreen(MainScreen.notificatoins),
                                  )),
                              Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(
                                    color: homePageController
                                                .currentScreenIndex ==
                                            3
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      AssetsPath.walletIcon,
                                      height: 35,
                                      width: 35,
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: () => homePageController
                                        .switchScreen(MainScreen.wallet),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )));
  }
}

enum MainScreen {
  browser(0),
  news(1),
  notificatoins(2),
  wallet(3);

  final int pageIndex;
  const MainScreen(this.pageIndex);
}
