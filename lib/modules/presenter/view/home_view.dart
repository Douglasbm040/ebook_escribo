import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/library_component.dart';

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


  final listFutures = [
    Modular.get<Controller>().getAllRequested(),
    Modular.get<Controller>().getAllDownloaded(),
    Modular.get<Controller>().getAllFavorite()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffDCDCDC),
        body: SafeArea(
          child: libraryComponent(
            page: _selectedIndex,
            controller: listFutures[_selectedIndex],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, fontFamily: "Afacad"),
              selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: "Afacad"),
              iconSize: 30,
              selectedIconTheme:
                  const IconThemeData(color: Colors.amberAccent, size: 32),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded),
                  label: 'Library',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.download_rounded),
                  label: 'Downloaded',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Favorites',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              onTap: _onItemTapped,
              elevation: 3,
            ),
          ),
        ));
  }
}
