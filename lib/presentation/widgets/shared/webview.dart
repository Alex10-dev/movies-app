import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeWebview extends StatefulWidget {

  final String videoKey;

  const YoutubeWebview ({
    super.key, 
    required this.videoKey
  });

  @override
  State<YoutubeWebview> createState() => _YoutubeWebviewState();
}

class _YoutubeWebviewState extends State<YoutubeWebview> {

  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    final videoUrl = 'https://www.youtube.com/embed/${widget.videoKey}?autoplay=0&modestbranding=1';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(videoUrl));

     if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          color: Colors.amber,
          height: 320,
          width: double.infinity,
          child: WebViewWidget( controller: _controller ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: colors.surface,
              child: Center(
                child: CircularProgressIndicator(
                  color: colors.onSurface,
                  strokeWidth: 6,
                ),
              ),
            ),
          ),
      ],
    );
  }
}