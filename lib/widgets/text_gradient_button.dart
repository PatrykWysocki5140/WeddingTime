import 'package:flutter/material.dart';
import 'package:wedding_time/constants.dart';
import 'dart:math';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Gradient? gradient;
  final double thickness;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.style,
    this.gradient,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient ??
            const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.3,
                0.7,
              ],
              colors: [kPrimaryColor, kAccentColor],
            ),
        color: kAccentColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}

class GradientRandomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Gradient? gradient;
  final double thickness;
  final Random _random = Random();

  GradientRandomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.style,
    this.gradient,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Gradient? randomGradient = gradient;

    if (randomGradient == null) {
      Alignment begin;
      Alignment end;
      double diff;

      do {
        begin = Alignment(
            _random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);
        end = Alignment(
            _random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);
        diff = (begin.x - end.x).abs() + (begin.y - end.y).abs();
      } while (diff < 2);

      Color color1 = kPrimaryColorGradient;
      Color color2 = kAccentColorGradient;
      randomGradient = LinearGradient(
        begin: begin,
        end: end,
        stops: const [0.3, 0.9],
        colors: [color1, color2],
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: randomGradient,
        color: kAccentColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        shape: BoxShape.rectangle,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}
