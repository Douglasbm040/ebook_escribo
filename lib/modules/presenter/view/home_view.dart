import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/library_component.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Modular.get<Controller>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initStateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffDCDCDC),
        body: Observer(builder: (_) {
          return SafeArea(
            child: libraryComponent(
              page: controller.selectedIndex,
              controllerBook:
                  controller.listObserver()[controller.selectedIndex],
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
            child: Observer(builder: (_) {
              return BottomNavigationBar(
                unselectedLabelStyle:
                    const TextStyle(fontSize: 14, fontFamily: "Afacad"),
                selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Afacad"),
                iconSize: 30,
                selectedIconTheme:
                    const IconThemeData(color: Colors.amberAccent, size: 32),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Semantics(
                        label: "botão para ir a aba Biblioteca",
                        child: const Icon(Icons.menu_book_rounded)),
                    label: 'Library',
                  ),
                  BottomNavigationBarItem(
                    icon: Semantics(
                        label: "botão para ir a aba baixados",
                        child: const Icon(Icons.download_rounded)),
                    label: 'Downloaded',
                  ),
                  BottomNavigationBarItem(
                    icon: Semantics(
                        label: "botão para ir a aba favoritos",
                        child: const Icon(Icons.book)),
                    label: 'Favorites',
                  ),
                ],
                currentIndex: controller.selectedIndex,
                selectedItemColor: Colors.black,
                onTap: controller.onItemTapped,
                elevation: 3,
              );
            }),
          ),
        ));
  }
}
