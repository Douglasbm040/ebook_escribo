import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationBookLoading extends StatelessWidget {
  const AnimationBookLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      color: Colors.white,
      elevation: 2,
      child: Center(
        child: ClipOval(
          child: Container(
            color: Colors.grey[300],
            height: 80,
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipOval(
                child: Lottie.asset(
                  'assets/animations/book.json',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
