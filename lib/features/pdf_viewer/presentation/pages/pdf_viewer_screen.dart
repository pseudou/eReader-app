import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../home/data/models/book.dart';
import '../../../../core/utils/pdf_helper.dart';

class PDFViewerScreen extends StatelessWidget {
  final Book book;

  PDFViewerScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(book.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.share),
          onPressed: () {
            // Share functionality
          },
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<bool>(
          future: PDFHelper.assetExists(book.assetPath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                return SfPdfViewer.asset(
                  book.assetPath,
                  canShowScrollHead: false,
                  enableDoubleTapZooming: true,
                  pageLayoutMode: PdfPageLayoutMode.single,
                );
              } else {
                return Center(child: Text('PDF not found'));
              }
            }
            return Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}