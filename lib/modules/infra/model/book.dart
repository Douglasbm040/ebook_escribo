import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';

class Book extends BookEntity {
  Book({
    String? path,
    required int id,
    required String title,
    required String author,
    required String coverUrl,
    required String downloadUrl,
    required int favorite,
  }) : super(
            path: path,
            id: id,
            title: title,
            author: author,
            coverUrl: coverUrl,
            downloadUrl: downloadUrl,
            favorite: favorite);

  Book.fromJsonDAO(Map<String, dynamic> json)
      : super(
            path: json["PATH"],
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
            path: book.path,
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
    data['FAVORITE'] = favorite;
    data['PATH'] = path;
    return data;
  }

  BookEntity copyWith({
    String? path,
    int? id,
    String? title,
    String? author,
    String? coverUrl,
    String? downloadUrl,
    int? favorite,
  }) {
    return BookEntity(
      path: path ?? this.path,
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      favorite: favorite ?? this.favorite,
    );
  }


}
