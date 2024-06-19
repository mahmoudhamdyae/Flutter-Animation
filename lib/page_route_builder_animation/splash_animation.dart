import 'dart:async';

import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation = Tween(begin: 1.0, end: 10.0).animate(controller);

    controller.addListener(() {
      if (controller.isCompleted) {
        Navigator.of(context).push(/*
            // MaterialPageRoute(builder: (context) => const Destination())
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
          return const Destination();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // return FadeTransition(opacity: animation, child: child,);
          final tween = Tween(begin: const Offset(0, -1), end: Offset.zero)
              .animate(CurvedAnimation(parent: animation, curve: Curves.ease));
          return SlideTransition(
            position: tween,
            child: child,
          );
        })*/

          MyCustomRouteTransition(route: const Destination())

        );
        Timer(const Duration(milliseconds: 500), () {
          controller.reset();
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            controller.forward();
          },
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
      body: const Center(
        child: Text('Hello Text!'),
      ),
    );
  }
}

class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;
  MyCustomRouteTransition({required this.route}): super(
      pageBuilder: (context, animation, secondaryAnimation) {
        return route;
      }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    // return FadeTransition(opacity: animation, child: child,);
    final tween = Tween(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: animation, curve: Curves.ease));
    return SlideTransition(
      position: tween,
      child: child,
    );
  }
  );
}