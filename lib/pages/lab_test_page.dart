import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../theme/app_colors.dart';
import '../widgets/code_editor_field.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/segmented_control.dart';

const String _kDefaultHtml = '''
<h1>Halo, Siswa!</h1>
<p>Coba ubah kode HTML, CSS, atau JS di tab atas lalu tekan
<b>Jalankan</b> untuk lihat hasilnya di sini.</p>
<button id="btn">Klik Saya</button>
''';

const String _kDefaultCss = '''
body {
  font-family: sans-serif;
  padding: 16px;
  color: #0f172a;
}
h1 {
  color: #0284c7;
}
#btn {
  background: #0284c7;
  color: white;
  border: none;
  padding: 10px 16px;
  border-radius: 8px;
  font-size: 14px;
}
''';

const String _kDefaultJs = '''
document.getElementById("btn").addEventListener("click", function () {
  alert("Tombol berhasil diklik!");
});
''';

/// Halaman Lab Test (tab index 2, menggantikan "Lab Fix").
///
/// Editor front-end mini: siswa menulis HTML/CSS/JS di tiga tab, lalu
/// menekan "Jalankan" untuk melihat live preview lewat WebView
/// (package `webview_flutter`).
class LabTestPage extends StatefulWidget {
  final String? initialHtml;
  final String? initialCss;
  final String? initialJs;

  const LabTestPage({super.key, this.initialHtml, this.initialCss, this.initialJs});

  @override
  State<LabTestPage> createState() => _LabTestPageState();
}

class _LabTestPageState extends State<LabTestPage> {
  late final TextEditingController _htmlController;
  late final TextEditingController _cssController;
  late final TextEditingController _jsController;
  late final InAppWebViewController? _webViewController;

  int _activeTab = 0; // 0 html, 1 css, 2 js

  @override
  void initState() {
    super.initState();
    _htmlController = TextEditingController(text: widget.initialHtml ?? _kDefaultHtml);
    _cssController = TextEditingController(text: widget.initialCss ?? _kDefaultCss);
    _jsController = TextEditingController(text: widget.initialJs ?? _kDefaultJs);

    // Jalankan sekali di awal supaya preview langsung terisi.
    WidgetsBinding.instance.addPostFrameCallback((_) => _runCode());
  }

  @override
  void dispose() {
    _htmlController.dispose();
    _cssController.dispose();
    _jsController.dispose();
    super.dispose();
  }

  String _buildDocument() {
    return '''
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<style>${_cssController.text}</style>
</head>
<body>
${_htmlController.text}
<script>${_jsController.text}</script>
</body>
</html>
''';
  }

  void _runCode() {
    final document = _buildDocument();
    _webViewController?.loadData(data: document);
    FocusScope.of(context).unfocus();
  }

  void _resetCode() {
    setState(() {
      _htmlController.text = _kDefaultHtml;
      _cssController.text = _kDefaultCss;
      _jsController.text = _kDefaultJs;
    });
    _runCode();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 2,
      headerSubtitle: 'Lab Test',
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lab Test: Coba Kode Front-End',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.slate900),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tulis HTML, CSS, dan JavaScript sendiri, lalu jalankan untuk melihat hasilnya secara langsung.',
                  style: TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.4),
                ),
                const SizedBox(height: 16),
                SegmentedControl(
                  options: const [
                    SegmentedOption(icon: Icons.html_outlined, label: 'HTML'),
                    SegmentedOption(icon: Icons.palette_outlined, label: 'CSS'),
                    SegmentedOption(icon: Icons.javascript_outlined, label: 'JS'),
                  ],
                  selectedIndex: _activeTab,
                  onChanged: (i) => setState(() => _activeTab = i),
                ),
                const SizedBox(height: 12),
                IndexedStack(
                  index: _activeTab,
                  children: [
                    CodeEditorField(
                      controller: _htmlController,
                      filename: 'index.html',
                      accent: AppColors.orange600,
                    ),
                    CodeEditorField(
                      controller: _cssController,
                      filename: 'style.css',
                      accent: AppColors.sky600,
                    ),
                    CodeEditorField(
                      controller: _jsController,
                      filename: 'script.js',
                      accent: AppColors.amber700,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: _runCode,
                          icon: const Icon(Icons.play_arrow, size: 20),
                          label: const Text('Jalankan', style: TextStyle(fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.sky600,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 44,
                      child: OutlinedButton.icon(
                        onPressed: _resetCode,
                        icon: const Icon(Icons.refresh, size: 18, color: AppColors.slate600),
                        label: const Text('Reset', style: TextStyle(color: AppColors.slate700)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.slate300),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Icon(Icons.visibility_outlined, size: 16, color: AppColors.slate600),
                    SizedBox(width: 6),
                    Text('Live Preview',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.slate700)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.slate200),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InAppWebView(
                    initialData: InAppWebViewInitialData(
                      data: _buildDocument(),
                    ),
                    initialSettings: InAppWebViewSettings(
                      isInspectable: true,
                      javaScriptEnabled: true,
                      mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
