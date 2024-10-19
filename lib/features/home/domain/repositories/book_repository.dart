import '../../data/models/book.dart';

class BookRepository {
  List<Book> getBooks() {
    return [
      Book(title: 'Solo Leveling', assetPath: 'assets/solo_leveling.pdf'),
    ];
  }
}