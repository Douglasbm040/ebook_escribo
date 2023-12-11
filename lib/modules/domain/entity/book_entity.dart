class BookEntity {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;
  final int favorite;

  BookEntity({required this.favorite, 
      required this.id,
      required this.title,
      required this.author,
      required this.coverUrl,
      required this.downloadUrl});
}
