import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:ebook_escribo/modules/presenter/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookComponent extends StatelessWidget {
  const BookComponent({
    super.key,
    required this.book,
    required this.pages,
  });
  final BookEntity book;
  final int pages;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  child: InkWell(
                    onTap: () async {
                      if (pages == 0) {
                        String texto = await Modular.get<Controller>().downloadBook(book);
                        final snackBar = SnackBar(
                          content: Text(texto),
                          duration: Duration(seconds: 3), // Duração da exibição
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Modular.to.pushNamed("/read", arguments: book);
                      }
                    },
                    child: SizedBox(
                      width: 300,
                      height: 250,
                      child: Image(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                            book.coverUrl,
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const CircularProgressIndicator();
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        Positioned(
          right: -1,
          child: InkWell(
            onTap: () async {
              await Modular.get<Controller>().favoriteToggle(book);
              final snackBar = SnackBar(
                content: Text(book.favorite == 2
                    ? "Livro favoritado"
                    : "Livro desfavoritado"),
                duration: const Duration(seconds: 3),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[200],
              child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.amber,
                  child: Icon(
                    book.favorite == 2
                        ? Icons.bookmark_outlined
                        : Icons.bookmark_rounded,
                    color: book.favorite == 2 ? Colors.redAccent : Colors.white,
                    size: 40,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
