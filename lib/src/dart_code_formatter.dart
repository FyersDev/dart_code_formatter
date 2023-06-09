import 'package:dart_style/dart_style.dart';
import 'package:flutter/widgets.dart';
import 'package:webviewx/webviewx.dart';

class DartCodeFomatter extends StatefulWidget {
  final double height;
  final double width;
  final String code;
  final bool runFormatter;
  const DartCodeFomatter({
    super.key,
    required this.height,
    required this.width,
    required this.code,
    this.runFormatter = false,
  });

  @override
  State<DartCodeFomatter> createState() => _DartCodeFomatterState();
}

class _DartCodeFomatterState extends State<DartCodeFomatter> {
  String? code;
  @override
  void initState() {
    if (widget.runFormatter) {
      code = DartFormatter().format(widget.code);
    } else {
      code = widget.code;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      height: widget.height,
      width: widget.width,
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) {
        controller.loadContent(
          'packages/dart_code_formatter/assets/code_viewer.html',
          SourceType.html,
          fromAssets: true,
        );
        // Image.asset('name',package: '',);

        Future.delayed(const Duration(seconds: 1), () {
          controller.callJsMethod('updateCodeContent', [code]);
        });
      },
    );
  }
}
