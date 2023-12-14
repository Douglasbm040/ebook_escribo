import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entity/book_entity.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Modular.get<Controller>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    libraryComponent(controller: Modular.get<Controller>().getAllRequested()),
    libraryComponent(controller: Modular.get<Controller>().getAllDownloaded()),
    libraryComponent(controller: Modular.get<Controller>().getAllFavorite()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffDCDCDC),
        body: SafeArea(child: _widgetOptions[_selectedIndex]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              iconSize: 30,
              selectedIconTheme:
                  const IconThemeData(color: Colors.amberAccent, size: 32),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded),
                  label: 'Library',
                  backgroundColor: Color(0xffDCDCDC),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
              elevation: 3,
            ),
          ),
        ));
  }
}

class libraryComponent extends StatefulWidget {
  const libraryComponent({
    super.key,
    required this.controller,
  });
  final Future<List<BookEntity>?> controller;

  @override
  State<libraryComponent> createState() => _libraryComponentState();
}

class _libraryComponentState extends State<libraryComponent> {
  bool isanimatedTitle = false;

  @override
  Widget build(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).textScaleFactor;
    return SizedBox(
      child: FutureBuilder<List<BookEntity>?>(
          future: widget.controller,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return snapshot.data?.length == 0
                ? const Center(child: Text('No books found'))
                : Column(
                    children: [
                      Expanded(
                          child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Animate(
                                      effects: const [
                                        ShimmerEffect(
                                            duration: Duration(seconds: 2)),
                                      ],
                                      child: const Row(
                                        children: [
                                          Text(
                                            "LabraryWay",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 40),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                50, 0, 0, 0),
                                            child: CircleAvatar(
                                              radius: 40,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 40,
                                                child: Icon(
                                                  Icons.menu_book,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                  Animate(
                                    effects: const [
                                      ShimmerEffect(
                                        duration: Duration(seconds: 4),
                                      ),
                                    ],
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      height: isanimatedTitle ? 0 : 35,
                                      child: Row(
                                        children: [
                                          AnimatedTextKit(
                                            isRepeatingAnimation: false,
                                            onFinished: () {
                                              setState(() {
                                                isanimatedTitle =
                                                    !isanimatedTitle;
                                              });
                                            },
                                            animatedTexts: [
                                              RotateAnimatedText("Leia +",
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  duration: const Duration(
                                                      seconds: 1)),
                                              RotateAnimatedText("Imagine +",
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  duration: const Duration(
                                                      seconds: 1)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                        flex: 3,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      2, // Número de colunas na grade
                                  crossAxisSpacing:
                                      5.0, // Espaçamento horizontal entre os itens
                                  mainAxisSpacing:
                                      5.0, // Espaçamento vertical entre os itens
                                  childAspectRatio: .6),
                          itemCount: snapshot
                              .data?.length, // Número total de itens na grade
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data?[index] == null
                                ? Center(
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
                                  )
                                : Stack(
                                    children: [
                                      Card(
                                        shadowColor: Colors.white,
                                        color: Colors.white,
                                        elevation: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Container(
                                                  width: 300,
                                                  height: 250,
                                                  child: Image(
                                                      fit: BoxFit.fill,
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        '${snapshot.data?[index].coverUrl}',
                                                      ),
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return const CircularProgressIndicator();
                                                      }),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                '${snapshot.data?[index].title}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                '${snapshot.data?[index].author}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Positioned(
                                        right: 0,
                                        child: CircleAvatar(
                                          radius: 22,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              child: Icon(
                                                Icons.bookmark_border_rounded,
                                                color: Colors.white,
                                              )),
                                        ),
                                      )
                                    ],
                                  );
                          },
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
