import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationSubTitle extends StatelessWidget {
  const AnimationSubTitle({
    super.key,
    required this.isanimatedTitle,
  });

  final bool isanimatedTitle;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        ShimmerEffect(
          duration: Duration(seconds: 4),
        ),
      ],
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: isanimatedTitle ? 0 : 35,
        child: Row(
          children: [
            AnimatedTextKit(
              repeatForever: false,
              isRepeatingAnimation: false,
              onFinished: () {
                /*setState(() {
                  isanimatedTitle =
                      !isanimatedTitle;
                });*/
              },
              animatedTexts: [
                RotateAnimatedText("Leia +",
                    textStyle: const TextStyle(
                        fontFamily: "Afacad",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    duration: const Duration(seconds: 1)),
                RotateAnimatedText("Imagine +",
                    textStyle: const TextStyle(
                        fontFamily: "Afacad",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    duration: const Duration(seconds: 1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
