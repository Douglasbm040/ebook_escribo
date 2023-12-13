import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
    libraryComponent(controller: Modular.get<Controller>()),
    Center(
      child: CircleAvatar(
        backgroundColor: Color(0xfff8fafc),
        child: Center(
          child: Lottie.asset(
            'assets/animations/book.json',
          ),
        ),
      ),
    ),
    const Center(
      child: Text('Favorites'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Library',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Saved',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
          elevation: 3,
        ));
  }
}

class libraryComponent extends StatelessWidget {
  const libraryComponent({
    super.key,
    required this.controller,
  });

  final Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: FutureBuilder<List<BookEntity>?>(
            future: controller.getAllRequested(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return snapshot.data?.length == 0
                  ? Center(child: Text('No books found'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Número de colunas na grade
                        crossAxisSpacing:
                            8.0, // Espaçamento horizontal entre os itens
                        mainAxisSpacing:
                            8.0, // Espaçamento vertical entre os itens
                      ),
                      itemCount: snapshot
                          .data?.length, // Número total de itens na grade
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.grey[100],
                          child: snapshot.data?[index] == null
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
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                        image: CachedNetworkImageProvider(
                                            '${snapshot.data?[index].coverUrl}',
                                            maxHeight: 100,
                                            maxWidth: 80),
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const CircularProgressIndicator();
                                        }),
                                    Text(
                                      'titulo: ${snapshot.data?[index].title}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      'autor: ${snapshot.data?[index].author}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                        );
                      },
                    );
            }),
      ),
    );
  }
}
