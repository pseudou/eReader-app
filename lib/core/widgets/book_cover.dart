import 'package:flutter/cupertino.dart';
import '../../features/home/data/models/book.dart';
import 'pdf_thumbnail.dart';

class BookCover extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCover({Key? key, required this.book, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: PdfThumbnail(assetPath: book.assetPath),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            book.title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}