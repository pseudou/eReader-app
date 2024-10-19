import 'package:flutter/cupertino.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/pdf_viewer/presentation/pages/pdf_viewer_screen.dart';
import '../features/home/data/models/book.dart';

class AppRouter {
  static const String home = '/';
  static const String pdfViewer = '/pdf_viewer';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      case pdfViewer:
        final book = settings.arguments as Book;
        return CupertinoPageRoute(builder: (_) => PDFViewerScreen(book: book));
      default:
        return CupertinoPageRoute(
          builder: (_) => CupertinoPageScaffold(
            child: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}