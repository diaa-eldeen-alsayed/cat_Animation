import 'package:flutter/material.dart';
import '../widget/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    catAnimation = Tween(begin: -35.0, end: -100.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
    boxController =
        new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    boxAnimation = Tween(begin: pi*0.6, end: pi*0.65).animate(
      CurvedAnimation(parent: boxController, curve: Curves.easeInOut),
    );
    boxAnimation.addStatusListener((status) {
     if (status == AnimationStatus.completed ){
       boxController.reverse();
     }
     else if(status == AnimationStatus.dismissed){
       boxController.forward();
     }
    });
    boxController.forward();
    // catController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation !"),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlab(),
              buildRightFlab(),
            ],
          ),
        ),
        onTap: () {

          if (catController.status == AnimationStatus.completed) {
            catController.reverse();
            boxController.forward();
          } else if (catController.status == AnimationStatus.dismissed) {
            catController.forward();
            boxController.stop();
          }
        },
      ),
    );
  }

  buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
            child: child, top: catAnimation.value, right: 0, left: 0);
      },
      child: Cat(),
    );
  }

  buildBox() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  buildLeftFlab() {
    return Positioned(
      left: 3,
      child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10,
            width: 125,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle:boxAnimation.value,
              alignment: Alignment.topLeft,
              child: child,
            );
          }),
    );
  }
  buildRightFlab() {
    return Positioned(
      right: 3,
      child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10,
            width: 125,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle:-boxAnimation.value,
              alignment: Alignment.topRight,
              child: child,
            );
          }),
    );
  }
}
