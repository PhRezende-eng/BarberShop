import 'package:flutter/material.dart';

class BSSplashPage extends StatefulWidget {
  const BSSplashPage({super.key});

  @override
  State<BSSplashPage> createState() => _BSSplashPageState();
}

class _BSSplashPageState extends State<BSSplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeigth => 100 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background_image_chair.png'),
            opacity: 0.2,
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: AnimatedOpacity(
              duration: const Duration(seconds: 3),
              curve: Curves.easeIn,
              opacity: _animationOpacityLogo,
              child: AnimatedContainer(
                width: _logoAnimationWidth,
                height: _logoAnimationHeigth,
                duration: const Duration(seconds: 3),
                curve: Curves.linearToEaseOut,
                child: Image.asset(
                  'assets/images/img_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
