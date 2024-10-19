import 'dart:convert';
import 'package:flutter/services.dart';
import '../../data/models/book.dart';

class BookRepository {
  Future<List<Book>> getBooks() async {
    List<Book> books = [];

    try {
      // Load the AssetManifest.json file
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);

      // Filter for PDF files in the assets folder
      final pdfAssets = manifestMap.keys
          .where((String key) => key.startsWith('assets/') && key.toLowerCase().endsWith('.pdf'))
          .toList();

      // Create Book objects for each PDF file
      for (String assetPath in pdfAssets) {
        String title = assetPath.split('/').last.replaceAll('.pdf', '');
        books.add(Book(title: title, assetPath: assetPath));
      }
    } catch (e) {
      print('Error loading PDF assets: $e');
    }

    return books;
  }
}