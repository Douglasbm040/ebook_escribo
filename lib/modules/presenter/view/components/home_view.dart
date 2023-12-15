import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationTitle extends StatelessWidget {
  const AnimationTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: const [
          ShimmerEffect(duration: Duration(seconds: 2)),
        ],
        child: const Row(
          children: [
            Text(
              "LibraryWay",
              style: TextStyle(
                  fontFamily: 'Kalnia',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40),
            ),
          ],
        ));
  }
}
