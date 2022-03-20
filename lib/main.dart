import 'package:clock_demo/clock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final AnimationController minuteAnimationController;
  late final AnimationController hourAnimationController;
  late final AnimationController secondAnimationController;

  double hour = 0, minute = 0, second = 0;

  @override
  void initState() {
    _setupAnimations();
    super.initState();
  }

  void _setupAnimations() {
    hourAnimationController =
        AnimationController(vsync: this, duration: const Duration(hours: 12));
    minuteAnimationController =
        AnimationController(vsync: this, duration: const Duration(minutes: 60));
    secondAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));

    final secondAnim = _getAnimation(secondAnimationController);
    secondAnim.addListener(() {
      setState(() {
        second = secondAnim.value;
      });
    });

    final minuteAnim = _getAnimation(minuteAnimationController);
    secondAnim.addListener(() {
      setState(() {
        minute = minuteAnim.value;
      });
    });

    final hourAnim = _getAnimation(hourAnimationController);
    hourAnim.addListener(() {
      setState(() {
        hour = hourAnim.value;
      });
    });

    hourAnimationController.repeat();

    minuteAnimationController.repeat();

    secondAnimationController.repeat();
  }

  Animation _getAnimation(AnimationController parent) {
    return Tween<double>(begin: 0, end: 60).animate(parent);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClockPainter(
        hourHand: hour,
        secondHand: second,
        minuteHand: minute,
      ),
      size: const Size(300, 300),
    );
  }

  @override
  void dispose() {
    hourAnimationController.dispose();
    minuteAnimationController.dispose();
    secondAnimationController.dispose();
    super.dispose();
  }
}
