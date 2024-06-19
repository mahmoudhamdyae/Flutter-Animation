import 'package:flutter/material.dart';

class LoginScreenAnimation extends StatefulWidget {
  const LoginScreenAnimation({super.key});

  @override
  State<LoginScreenAnimation> createState() => _LoginScreenAnimationState();
}

class _LoginScreenAnimationState extends State<LoginScreenAnimation>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> logoFadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500)
    );
    logoFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
    slideAnimation = Tween(
        begin: const Offset(-1, -1),
        end: Offset.zero
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    scaleAnimation = Tween(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.forward();

    logoFadeAnimation.addListener(() {
      debugPrint(logoFadeAnimation.status.toString());
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: logoFadeAnimation,
              child: const FlutterLogo(
                size: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ScaleTransition(
                scale: scaleAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
