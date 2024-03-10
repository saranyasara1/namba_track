import 'package:animate_do/animate_do.dart';
import 'helpers/ColorsSys.dart';
import 'helpers/Strings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<WelcomeScreen> {
  late PageController _pageController;
  int currentIndex = 0;
  bool skipClicked = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                skipClicked = true;
              });
              // Navigate to the login page after animation completion
              Future.delayed(Duration(milliseconds: 500), () {});
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: AnimatedOpacity(
                opacity: skipClicked ? 0.0 : 1.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: ColorSys.gray,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                image: 'assets/images/step-one.png',
                title: Strings.stepOneTitle,
                content: Strings.stepOneContent,
              ),
              makePage(
                reverse: true,
                image: 'assets/images/step-two.png',
                title: Strings.stepTwoTitle,
                content: Strings.stepTwoContent,
              ),
              makePage(
                image: 'assets/images/step-three.png',
                title: Strings.stepThreeTitle,
                content: Strings.stepThreeContent,
              ),
              // Additional page with Get Started button
              makePageWithButton(
                image: 'assets/images/step-one.png',
                title: Strings.getStartedTitle,
                content: Strings.getStartedContent,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({
    required String image,
    required String title,
    required String content,
    bool reverse = false,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    FadeInUp(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(image),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : SizedBox(),
          FadeInUp(
            duration: Duration(milliseconds: 900),
            child: Text(
              title,
              style: TextStyle(
                color: ColorSys.primary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FadeInUp(
            duration: Duration(milliseconds: 1200),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorSys.gray,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          reverse
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  // Widget for the last page with Get Started button
  Widget makePageWithButton({
    required String image,
    required String title,
    required String content,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FadeInUp(
            child: Image.asset(image),
          ),
          SizedBox(height: 30),
          FadeInUp(
            duration: Duration(milliseconds: 900),
            child: Text(
              title,
              style: TextStyle(
                color: ColorSys.primary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInUp(
            duration: Duration(milliseconds: 1200),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorSys.gray,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 50),
          FadeInUp(
            duration: const Duration(milliseconds: 1500),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: ColorSys.secoundry,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 4; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
