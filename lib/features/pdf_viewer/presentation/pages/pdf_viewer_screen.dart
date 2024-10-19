import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../home/data/models/book.dart';
import '../../../../core/utils/pdf_helper.dart';

class PDFViewerScreen extends StatefulWidget {
  final Book book;

  PDFViewerScreen({required this.book});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void showAnalyzeButton(BuildContext context, PdfTextSelectionChangedDetails details) {
    _removeOverlay();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.bottom + 10,
        left: details.globalSelectedRegion!.left,
        child: Material(
          color: Colors.transparent,
          child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minSize: 0,
            child: Text('Context?', style: TextStyle(color: CupertinoColors.white)),
            onPressed: () {
              _removeOverlay();
              analyzeSelectedText(context, details.selectedText ?? '');
            },
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.book.title),
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
          future: PDFHelper.assetExists(widget.book.assetPath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                return SfPdfViewer.asset(
                  widget.book.assetPath,
                  canShowScrollHead: false,
                  enableDoubleTapZooming: true,
                  pageLayoutMode: PdfPageLayoutMode.single,
                  enableTextSelection: true,
                  canShowTextSelectionMenu: false,
                  onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                    if (details.selectedText != null && details.selectedText!.isNotEmpty) {
                      print("Selected text: ${details.selectedText}");
                      showAnalyzeButton(context, details);
                    } else {
                      _removeOverlay();
                    }
                  },
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

  void analyzeSelectedText(BuildContext context, String selectedText) {
    print("Analyzing: $selectedText");
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Context'),
        content: Text('Context : $selectedText'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}