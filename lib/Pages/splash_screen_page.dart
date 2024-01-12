import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';

class SplashScreenPage extends StatefulWidget {
  final VoidCallback onEnd;
  final SplashScreenController controller;
  const SplashScreenPage(
      {super.key, required this.onEnd, required this.controller});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  // #region Variables
  late final AnimationController _firstAnimation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000));
  late final AnimationController _secondAnimation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<double> _colorsAnimation =
      Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(parent: _secondAnimation, curve: Curves.ease),
  );
  // #endregion

// #region Init
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(
      () {
        if (widget.controller._isStart) {
          _firstAnimation.reverse().then(
            (value) {
              _secondAnimation.forward().then((value) {
                widget.onEnd();
              });
            },
          );
        } else if (widget.controller._isError) {
          _firstAnimation.forward();
        } else if (widget.controller._removeError) {
          _firstAnimation.repeat(reverse: true);
        }
      },
    );

    _firstAnimation.repeat(reverse: true);
  }
// #endregion

  // #region Widgets
  Container _gradientContainer(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            const Color(0xFFcacaca).withOpacity(0.7),
            Colors.transparent,
          ],
          center: Alignment.center,
          radius: lerpDouble(3, 0, _firstAnimation.value) ?? 0,
          stops: const [0, 1],
        ),
      ),
    );
  }

  Image _hexBackground(Size size) {
    return Image.asset(
      "assets/hex_background.png",
      fit: BoxFit.cover,
      height: size.height,
      width: size.width,
      color: Colors.black,
    );
  }

  AnimatedBuilder _transitionContainer(Size size, BuildContext context) {
    return AnimatedBuilder(
      animation: _secondAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _colorsAnimation.value,
          child: child,
        );
      },
      child: Container(
        height: size.height,
        width: size.width,
        color: BackgroundColor(context),
      ),
    );
  }
  // #endregion

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: Stack(
        children: [
          Positioned(
            height: size.height,
            width: size.width,
            child: AnimatedBuilder(
              animation: _firstAnimation,
              builder: (context, child) {
                return Stack(
                  children: [
                    _gradientContainer(size),
                    _hexBackground(size),
                    _transitionContainer(size, context),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// #region Controller
class SplashScreenController extends ChangeNotifier {
  bool _isStart = false;
  bool _isError = false;
  bool _removeError = false;

  void start() {
    _isStart = true;
    notifyListeners();
  }

  void isError() {
    _isError = true;
    notifyListeners();
  }

  void removeError() {
    _isError = false;
    _removeError = true;
    notifyListeners();
  }
}
// #endregion
