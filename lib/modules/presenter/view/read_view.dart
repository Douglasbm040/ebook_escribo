import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';

class ReadView extends StatefulWidget {
  const ReadView({super.key});

  @override
  State<ReadView> createState() => _ReadViewState();
}

class _ReadViewState extends State<ReadView> {
  final book = Modular.args.data as BookEntity;
  @override
  void initState() {
    super.initState();
  }

  initReadEpub(String path) {
    Future.delayed(const Duration(milliseconds: 500));
    
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: book.author,
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: false,
    );

    // get current locator
    VocsyEpub.locatorStream.listen((locator) {
    
    });

    VocsyEpub.open(
      path,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
   
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            book.path != null
                ? Column(
                    children: [
                      Card(
                        shadowColor: Colors.white,
                        color: Colors.white,
                        elevation: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: width * .7,
                                  height: height * .5,
                                  child: Image(
                                      fit: BoxFit.fill,
                                      image: CachedNetworkImageProvider(
                                        book.coverUrl,
                                      ),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const CircularProgressIndicator();
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                book.title,
                                style: const TextStyle(
                                    fontFamily: "Afacad",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                book.author,
                                style: const TextStyle(
                                  fontFamily: "Afacad",
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amberAccent,
                            ),
                            onPressed: () {
                              initReadEpub(book.path!);
                            },
                            child: const SizedBox(
                              height: 80,
                              width: 230,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Toque para ler",
                                    style: TextStyle(
                                        fontFamily: "Afacad",
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.amber,
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: Icon(
                                              Icons.menu_book,
                                            )),
                                      ))
                                ],
                              )),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent[100]),
                            onPressed: () {
                              Modular.to.pop();
                            },
                            child: SizedBox(
                              height: 80,
                              width: 230,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Voltar",
                                    style: TextStyle(
                                        fontFamily: "Afacad",
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 0, 0, 0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Colors.deepOrangeAccent[200],
                                        child: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: Icon(
                                              Icons.arrow_back,
                                            )),
                                      ))
                                ],
                              )),
                            )),
                      )
                    ],
                  )
                : Column(
                    children: [
                      ClipOval(
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
                      const Text("Carregando...")
                    ],
                  ),
          ],
        ),
      ],
    )));
  }
}
