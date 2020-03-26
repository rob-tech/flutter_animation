import 'dart:math';

import 'package:animation_flutter/src/widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimationOne;
  Animation<double> boxAnimationTwo;
  AnimationController boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );
    boxAnimationOne = Tween(begin: pi * 0.6, end: pi * 0.61).animate(CurvedAnimation(
      parent: boxController,
      curve: Curves.easeOutCirc,
    ));
    boxAnimationTwo = Tween(begin: pi * 0.58, end: pi * 0.59).animate(CurvedAnimation(
      parent: boxController,
      curve: Curves.easeOutCirc,
    ));

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(begin: -38.0, end: -82.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));
     

        boxAnimationOne.addStatusListener((status){
           if(status == AnimationStatus.completed){
             boxController.reverse();
           }else if(status == AnimationStatus.dismissed){
             boxController.forward();
           }
        });
         boxAnimationTwo.addStatusListener((status){
           if(status == AnimationStatus.completed){
             boxController.reverse();
           }else if(status == AnimationStatus.dismissed){
             boxController.forward();
           }
        });
         boxController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
            child: child, top: catAnimation.value, right: 0.0, left: 0.0);
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(height: 200.0, width: 200.0, color: Colors.brown);
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      top: 1.0,
      child: AnimatedBuilder(
          animation: boxAnimationOne,
          child: Container(height: 10.0, width: 125.0, color: Colors.brown),
          builder: (context, child) {
            return Transform.rotate(
                child: child,
                alignment: Alignment.topLeft,
                angle: boxAnimationOne.value);
          }),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      top: 1.0,
      child: AnimatedBuilder(
          animation: boxAnimationTwo,
          child: Container(height: 10.0, width: 125.0, color: Colors.brown),
          builder: (context, child) {
            return Transform.rotate(
                child: child,
                alignment: Alignment.topRight,
                angle: -boxAnimationTwo.value);
          }),
    );
  }

  onTap() {

    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }
}
