import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';

class Book extends BookEntity {
  Book({
    required int id,
    required String title,
    required String author,
    required String coverUrl,
    required String downloadUrl,
  }) : super(
            id: id,
            title: title,
            author: author,
            coverUrl: coverUrl,
            downloadUrl: downloadUrl,
            favorite: 1);

  Book.fromJsonDAO(Map<String, dynamic> json)
      : super(
            id: json['ID'],
            title: json['TITLE'],
            author: json['AUTHOR'],
            coverUrl: json['COVER_URL'],
            downloadUrl: json['DOWNLOAD_URL'],
            favorite: 1);
  Book.fromJsonRequest(Map<String, dynamic> json)
      : super(
            id: json['id'],
            title: json['title'],
            author: json['author'],
            coverUrl: json['cover_url'],
            downloadUrl: json['download_url'],
            favorite: 1);

  Book.fromBookEntity(BookEntity book)
      : super(
            id: book.id,
            title: book.title,
            author: book.author,
            coverUrl: book.coverUrl,
            downloadUrl: book.downloadUrl,
            favorite: book.favorite);

  Map<String, dynamic> toJsonDAO() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = id;
    data['TITLE'] = title;
    data['AUTHOR'] = author;
    data['COVER_URL'] = coverUrl;
    data['DOWNLOAD_URL'] = downloadUrl;
    return data;
  }
}
