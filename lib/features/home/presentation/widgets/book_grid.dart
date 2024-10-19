import 'package:flutter/cupertino.dart';
import '../../../../core/widgets/book_cover.dart';
import '../../data/models/book.dart';
import '../../../../routing/app_router.dart';

class BookGrid extends StatelessWidget {
  final List<Book> books;

  const BookGrid({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return BookCover(
            book: books[index],
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouter.pdfViewer,
                arguments: books[index],
              );
            },
          );
        },
        childCount: books.length,
      ),
    );
  }
}