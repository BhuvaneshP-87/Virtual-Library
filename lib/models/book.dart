class Book {
  String title;
  List author;
  String publisher;
  String description;
  int pages;
  String category;
  String thumbnail;
  String webLink;
  String isbn;
  bool isDownload;
  String pdf;
  Book();
}
class BookThumbnails{
  String smallThumbnail;
  BookThumbnails();
}

class BookCards{
  int totalBooks;
  String id;
  String title;
  List author;
  String smallThumbnail;
  String isbn;
  BookCards();
}