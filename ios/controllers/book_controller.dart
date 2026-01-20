import 'package:get/get.dart';
import '../models/book.dart';
import '../services/db_service.dart';

class BookController extends GetxController {
  var books = <Book>[].obs;
  var favorites = <Book>[].obs;

  Future<void> loadBooks() async {
    books.value = await DBService.getBooks();
  }

  void addToFavorites(Book book) {
    favorites.add(book);
  }

  void removeFromFavorites(Book book) {
    favorites.remove(book);
  }
}
