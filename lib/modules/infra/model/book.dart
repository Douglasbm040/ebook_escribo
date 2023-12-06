import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';

class Book extends BookEntity {
  Book({
    required int id,
    required String title,
    required String author,
    required String coverUrl,
    required String downloadUrl,
  }) : super(id: id, title: title, author: author, coverUrl: coverUrl, downloadUrl: downloadUrl);

  Book.fromJson(Map<String, dynamic> json) : super(
    id: json['id'],
    title: json['title'],
    author: json['author'],
    coverUrl: json['cover_url'],
    downloadUrl: json['download_url'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['cover_url'] = coverUrl;
    data['download_url'] = downloadUrl;
    return data;
  }
}
