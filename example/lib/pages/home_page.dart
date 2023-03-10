///
/// [Author] Alex (https://github.com/Alex525)
/// [Date] 2020-05-31 21:38
///
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/extensions.dart';
import '../constants/resource.dart';
import '../constants/screens.dart';
import 'multi_assets_page.dart';
import 'single_assets_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(pageControllerListener);
  }

  void selectIndex(int index) {
    if (index == currentIndex) {
      return;
    }
    controller.animateToPage(
      index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  void pageControllerListener() {
    final int currentPage = controller.page.round();
    if (currentPage != currentIndex) {
      currentIndex = currentPage;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget get header => Container(
        margin: const EdgeInsets.only(top: 30.0),
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Hero(
                tag: 'LOGO',
                child: Image.asset(
                  R.ASSETS_FLUTTER_CANDIES_LOGO_PNG,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'WeChat Asset Picker',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Demo for the package.',
                  style: context.themeData.textTheme.caption,
                ),
              ],
            ),
            const SizedBox(width: 20.0),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Screens.mediaQuery.platformBrightness.isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              header,
              Expanded(
                child: PageView(
                  controller: controller,
                  children: <Widget>[
                    MultiAssetsPage(),
                    SingleAssetPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: selectIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library),
              label: 'Multi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Single',
            ),
          ],
        ),
      ),
    );
  }
}
