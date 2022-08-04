import 'dart:math';

import 'package:flutter/material.dart';

class AnimationControl extends StatefulWidget {
  const AnimationControl({Key? key}) : super(key: key);

  @override
  State<AnimationControl> createState() => _AnimationControlState();
}

class _AnimationControlState extends State<AnimationControl> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _easeInAnimation;
  late Animation _rotateAnimation;
  late Animation _easeOutAnimation;

  @override
  void initState(){
    super.initState();

    _animationController =

        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _animationController.addListener(() => setState(() {}));

    _animationController.repeat(reverse: false);

    _easeInAnimation = CurvedAnimation(parent: _animationController,
        curve: const Interval(0.0, 0.3, curve: Curves.fastLinearToSlowEaseIn));
    _rotateAnimation = Tween<double> (begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(parent: _animationController, curve: const Interval(0.2, 0.7))
        );
    _easeOutAnimation = CurvedAnimation(parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32),
      color: Colors.pinkAccent,
      ),
        width: 200.0,
        height: 200.0,
        ),
      builder: (_, Widget? child) => Transform.scale(
        scale: _easeInAnimation.value,
        child: Transform.rotate(
          angle: _rotateAnimation.value,
          child: Transform.scale(
            scale: _easeOutAnimation.value,
            child: child,
          ),
        )),
    );
    }
}
