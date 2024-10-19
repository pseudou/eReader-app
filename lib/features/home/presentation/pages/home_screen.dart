import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../widgets/book_grid.dart';

class HomeScreen extends StatelessWidget {
  final BookRepository bookRepository = BookRepository();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppConstants.homeTitle),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            // Add new book functionality
          },
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<List<Book>>(
          future: bookRepository.getBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final books = snapshot.data ?? [];
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CupertinoSearchTextField(
                        placeholder: AppConstants.searchPlaceholder,
                      ),
                    ),
                  ),
                  BookGrid(books: books),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}