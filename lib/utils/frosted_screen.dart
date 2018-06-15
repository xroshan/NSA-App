import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

class Frosted extends StatelessWidget {

  final double width;
  final double height;

  const Frosted({@required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width, 
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5)
          ),
        ),
      ),
    );
  }
}