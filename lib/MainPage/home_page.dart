import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funtury/assets_path.dart';

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
  int _currentScreenIndex = 0;
  final List<bool> _hasVisited = [false, false, false, false];

  void switchScreen(MainScreen screen) {
    setState(() {
      _currentScreenIndex = screen.pageIndex;
      _hasVisited[screen.pageIndex] = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _hasVisited[0] = true;
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
                stops: [
                  0.85,
                  1.0,
                ],
                colors: [
                  Colors.white,
                  Theme.of(context).colorScheme.primary,
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                IndexedStack(
                  alignment: Alignment.center,
                  index: _currentScreenIndex,
                  children: [
                    LazyLoadPage(
                      shouldBuild: _hasVisited[0],
                      builder: () => const Text('Browser'),
                    ),
                    LazyLoadPage(
                      shouldBuild: _hasVisited[1],
                      builder: () => const Text('News'),
                    ),
                    LazyLoadPage(
                      shouldBuild: _hasVisited[2],
                      builder: () => const Text('Notifications'),
                    ),
                    LazyLoadPage(
                      shouldBuild: _hasVisited[3],
                      builder: () => const Text('Wallet'),
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
                              color: _currentScreenIndex == 0
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
                              onPressed: () => switchScreen(MainScreen.browser),
                            )),
                        Container(
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                              color: _currentScreenIndex == 1
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
                              onPressed: () => switchScreen(MainScreen.news),
                            )),
                        Container(
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                              color: _currentScreenIndex == 2
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
                              onPressed: () =>
                                  switchScreen(MainScreen.notificatoins),
                            )),
                        Container(
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                              color: _currentScreenIndex == 3
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
                              onPressed: () => switchScreen(MainScreen.wallet),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
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
