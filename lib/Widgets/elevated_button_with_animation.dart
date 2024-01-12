import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';

class ElevatedButtonWithAnimation extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final ValueNotifier<ElevatedButtonAnimationState>
      elevatedButtonAnimationState;
  const ElevatedButtonWithAnimation(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.elevatedButtonAnimationState});

  @override
  State<ElevatedButtonWithAnimation> createState() =>
      _ElevatedButtonWithAnimationState();
}

class _ElevatedButtonWithAnimationState
    extends State<ElevatedButtonWithAnimation> {
  Widget _child() {
    switch (widget.elevatedButtonAnimationState.value) {
      case ElevatedButtonAnimationState.normal:
        return Text(
          widget.text,
          style: TextStyle(
            color: AccentColor(context),
            fontWeight: FontWeight.w500,
          ),
        );
      case ElevatedButtonAnimationState.loading:
        return CircularProgressIndicator(
          color: AccentColor(context),
          backgroundColor: Colors.transparent,
        );
      case ElevatedButtonAnimationState.finished:
        return Icon(
          Icons.done,
          color: AccentColor(context),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.elevatedButtonAnimationState,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (widget.elevatedButtonAnimationState.value ==
                ElevatedButtonAnimationState.normal) {
              widget.onPressed();
            }
            return;
          },
          child: FittedBox(
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 500,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MainColor(context),
                borderRadius: BorderRadius.circular(
                    widget.elevatedButtonAnimationState.value ==
                            ElevatedButtonAnimationState.normal
                        ? 12
                        : 100),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(1, 1),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _child(),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum ElevatedButtonAnimationState { normal, loading, finished }
