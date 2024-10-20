import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../home/data/models/book.dart';
import '../../../../core/utils/pdf_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PDFViewerScreen extends StatefulWidget {
  final Book book;

  PDFViewerScreen({required this.book});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late BuildContext _context;
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

  @override
  void initState(){
    super.initState();
    _context =  context;
  }

  Future<Map<String, dynamic>?> _analyzeText(String selectedText) async {
    return await makePostRequest('http://127.0.0.1:5000/similar-sentences', {'sentence': selectedText,'title':'Reverend Insanity'});
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
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => FutureBuilder<Map<String, dynamic>?>(
                  future: _analyzeText(details.selectedText ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CupertinoAlertDialog(
                        title: Text('Analyzing'),
                        content: Column(
                          children: [
                            CupertinoActivityIndicator(),
                            SizedBox(height: 10),
                            Text('Please wait...'),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return CupertinoAlertDialog(
                        title: Text('Error'),
                        content: Text('An error occurred. Please try again.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    } else {
                      return CupertinoAlertDialog(
                        title: Text('Context'),
                        content: Text(snapshot.data?['similar_sentences'] ?? 'No context available'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    }
                  },
                ),
              );
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
                  pageLayoutMode: PdfPageLayoutMode.continuous,
                  enableTextSelection: true,
                  canShowTextSelectionMenu: false,
                  onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                    if (details.selectedText != null && details.selectedText!.isNotEmpty) {
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

  Future<Map<String, dynamic>?> makePostRequest(String url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print("Exception during post request call");
      print(e);
    }
    return null;
  }
}