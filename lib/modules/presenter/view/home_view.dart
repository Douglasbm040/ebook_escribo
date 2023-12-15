import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entity/book_entity.dart';
import 'components/animation_book_loading.dart';
import 'components/animation_is_empty.dart';
import 'components/animation_sub_title.dart';
import 'components/book_component.dart';
import 'components/button_favorite.dart';
import 'components/grid_view_component.dart';
import 'components/home_view.dart';
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
                  icon: Icon(Icons.book),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_outlined),
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
