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
                  fontSize: 25),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: CircleAvatar(
                radius: 25,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.menu_book,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
