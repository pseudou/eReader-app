// lib/core/widgets/pdf_thumbnail.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfThumbnail extends StatefulWidget {
  final String assetPath;

  const PdfThumbnail({Key? key, required this.assetPath}) : super(key: key);

  @override
  _PdfThumbnailState createState() => _PdfThumbnailState();
}

class _PdfThumbnailState extends State<PdfThumbnail> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: SfPdfViewer.asset(
            widget.assetPath,
            controller: _pdfViewerController,
            pageSpacing: 0,
            initialZoomLevel: 1.0,
            initialScrollOffset: Offset.zero,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            enableDoubleTapZooming: false,
            enableTextSelection: false,
            enableDocumentLinkAnnotation: false,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              _pdfViewerController.jumpToPage(1);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }
}