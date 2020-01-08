import 'package:flutter/material.dart';

import 'PageIndiator.dart';
import 'data.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  int currentPage = 0;
  bool isEndPage = false;
  AnimationController animationController;
  Animation<double> _animation;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:pageList[currentPage].titleGradient,
              begin: Alignment.topCenter,
              tileMode: TileMode.clamp,
//              stops: [0.0, 1.0],
              end: Alignment.bottomCenter)),
      child: Scaffold(
          //背景弄成透明
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pageList.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                      if (currentPage == pageList.length - 1) {
                        isEndPage = true;
                        animationController.forward();
                      } else {
                        isEndPage = false;
                        animationController.reset();
                      }
                      print(isEndPage);
                    });
                  },
                  itemBuilder: (context, index) {
                    return new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(pageList[currentPage].imageUrl),
                      ],
                    );
                  }),
              Positioned(
                bottom: 55,
                left: 30,
                child: Container(
                  width: 160,
                  child: PageIndiator(currentPage, pageList.length),
                ),
              ),
              Positioned(
                bottom: 50,
                right: 30,
                child: ScaleTransition(
                  scale: _animation,
                  child: isEndPage
                      ? FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        )
                      : Container(),
                ),
              )
            ],
          )),
    );
  }
}
