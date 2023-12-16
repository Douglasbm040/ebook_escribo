import 'package:ebook_escribo/modules/presenter/view/components/animation_book_loading.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationIsEmpty extends StatelessWidget {
  const AnimationIsEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? const AnimationBookLoading()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 200,
                            color: Colors.white,
                            child: ClipOval(
                              child: Container(
                                height: 100,
                                color: Colors.amber[200],
                                child: Lottie.asset(
                                  repeat: false,
                                  height: 10,
                                  'assets/animations/semregistros.json',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Sem registros',
                          style: const TextStyle(
                              fontFamily: "Afacad",
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                );
        });
  }
}
