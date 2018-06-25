import 'package:flutter/material.dart';

class ButtonAnimation {
  ButtonAnimation(this.controller)
      : buttonSqueezeanimation = new Tween(
          begin: 300.0,
          end: 70.0,
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.0,
              0.200,
            ),
          ),
        ),
        containerCircleAnimation = new EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 50.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.500,
              1.000,
              curve: Curves.ease,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation<double> buttonSqueezeanimation;
}

class LoginEnterAnimation {
  LoginEnterAnimation(this.controller)
      : backdropBlur = new Tween(begin: 0.0, end: 3.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.400,
              1.000,
              curve: Curves.linear,
            ),
          ),
        ),
        avatarSize = new Tween(begin: 2.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.500,
              1.000,
              curve: Curves.ease,
            ),
          ),
        ),
        opacity = new Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Interval(0.500, 0.500)));

  final AnimationController controller;

  final Animation<double> backdropBlur;
  final Animation<double> avatarSize;
  final Animation<double> opacity;
}
