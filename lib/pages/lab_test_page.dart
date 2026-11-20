import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter/foundation.dart';
import '../theme/app_colors.dart';
import '../widgets/code_editor_field.dart';
import '../widgets/glass_morphism_box.dart';
import '../widgets/main_scaffold.dart';

String _kDefaultHtml = '''
<h1>Halo, Siswa!</h1>
<p>Coba ubah kode HTML, CSS, atau JS di tab atas lalu tekan
<b>Jalankan</b> untuk lihat hasilnya di sini.</p>
<button id="btn">Klik Saya</button>
''';

String _kDefaultCss = '''
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
  border-radius: 999px;
  font-size: 14px;
  cursor: pointer;
}
''';

String _kDefaultJs = '''
document.getElementById("btn").addEventListener("click", function () {
  alert("Tombol berhasil diklik!");
});
''';

/// Halaman Lab Test (tab index 2) bergaya Glassmorphism / Liquid Glass.
class LabTestPage extends StatefulWidget {
  final String? initialHtml;
  final String? initialCss;
  final String? initialJs;

  const LabTestPage({
    super.key,
    this.initialHtml,
    this.initialCss,
    this.initialJs,
  });

  @override
  State<LabTestPage> createState() => _LabTestPageState();
}

class _LabTestPageState extends State<LabTestPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _htmlController;
  late final TextEditingController _cssController;
  late final TextEditingController _jsController;
  late final AnimationController _entranceController;
  InAppWebViewController? _webViewController;

  int _activeTab = 0; // 0 html, 1 css, 2 js
  double? _dragTab;

  List<({IconData icon, String label, Color accent})> get _tabs => [
        (icon: Icons.html_rounded, label: 'HTML', accent: AppColors.orange600),
        (icon: Icons.palette_rounded, label: 'CSS', accent: AppColors.sky600),
        (
          icon: Icons.javascript_rounded,
          label: 'JS',
          accent: AppColors.amber700
        ),
      ];

  @override
  void initState() {
    super.initState();
    _htmlController =
        TextEditingController(text: widget.initialHtml ?? _kDefaultHtml);
    _cssController =
        TextEditingController(text: widget.initialCss ?? _kDefaultCss);
    _jsController =
        TextEditingController(text: widget.initialJs ?? _kDefaultJs);

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 780),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
      _runCode();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _htmlController.dispose();
    _cssController.dispose();
    _jsController.dispose();
    super.dispose();
  }

  /// Animasi geser bergiliran ringan (GPU-friendly) senada dengan HomePage.
  Widget _staggerSlide({
    required double start,
    required double end,
    required Widget child,
    double slideDistance = 72.0,
  }) {
    final curve = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(
        start.clamp(0.0, 0.90),
        end.clamp(0.10, 1.0),
        curve: Curves.easeOutQuart,
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: curve,
        child: child,
        builder: (context, cachedChild) {
          final offsetX = (1.0 - curve.value) * slideDistance;
          return Transform.translate(
            offset: Offset(offsetX, 0),
            child: cachedChild,
          );
        },
      ),
    );
  }

  void _selectTab(int index) {
    final clamped = index.clamp(0, _tabs.length - 1);
    setState(() {
      _dragTab = null;
      if (_activeTab != clamped) {
        HapticFeedback.selectionClick();
        _activeTab = clamped;
      }
    });
  }

  String _buildDocument() {
    return '''
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<style>${_cssController.text}</style>
<script>
  window.alert = function(msg) {
    var text = msg === undefined ? '' : String(msg);
    if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
      window.flutter_inappwebview.callHandler('onJsAlert', text);
    }
  };
</script>
</head>
<body>
${_htmlController.text}
<script>${_jsController.text}</script>
</body>
</html>
''';
  }

  void _runCode() {
    HapticFeedback.lightImpact();
    final document = _buildDocument();
    _webViewController?.loadData(data: document);
    FocusScope.of(context).unfocus();
  }

  void _resetCode() {
    HapticFeedback.selectionClick();
    setState(() {
      _htmlController.text = _kDefaultHtml;
      _cssController.text = _kDefaultCss;
      _jsController.text = _kDefaultJs;
    });
    _runCode();
  }

  void _showGlassAlert(String message) {
    if (!mounted) return;
    HapticFeedback.mediumImpact();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Tutup Alert',
      barrierColor: AppColors.slate900.withOpacity(0.28),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (dialogContext, _, __) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Material(
                color: Colors.transparent,
                child: GlassMorphismBox(
                  borderRadius: 30,
                  opacity: 0.68,
                  blurSigma: 8,
                  enableBlur: true,
                  padding: const EdgeInsets.all(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.slate900.withOpacity(0.16),
                      blurRadius: 28,
                      spreadRadius: -4,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: AppColors.sky600.withOpacity(0.18),
                      blurRadius: 32,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.sky600,
                              const Color(0xFF6366F1),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.85),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.sky600.withOpacity(0.32),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.notifications_active_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sky50.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppColors.sky200),
                        ),
                        child: Text(
                          'OUTPUT JAVASCRIPT • ALERT',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.sky700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        message.isEmpty ? '(Pesan kosong)' : message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate900,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.sky600,
                              const Color(0xFF6366F1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.sky600.withOpacity(0.30),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: const Text(
                            'Oke, Mengerti',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.88, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).padding.bottom + 104;

    return MainScaffold(
      currentIndex: 2,
      headerSubtitle: 'Lab Test',
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomSpace),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _staggerSlide(
                  start: 0.00,
                  end: 0.44,
                  slideDistance: 60,
                  child: GlassMorphismBox(
                    borderRadius: 28,
                    opacity: 0.48,
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.sky600,
                                const Color(0xFF6366F1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.sky600.withOpacity(0.28),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.science_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lab Test: Coba Kode Front-End',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.slate900,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Tulis HTML, CSS, dan JS lalu jalankan untuk melihat hasil langsung.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.slate600,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _staggerSlide(
                  start: 0.08,
                  end: 0.52,
                  slideDistance: 72,
                  child: _buildLiquidTabSwitcher(),
                ),
                const SizedBox(height: 12),
                _staggerSlide(
                  start: 0.16,
                  end: 0.62,
                  slideDistance: 84,
                  child: GlassMorphismBox(
                    borderRadius: 26,
                    opacity: 0.42,
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: IndexedStack(
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
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _staggerSlide(
                  start: 0.24,
                  end: 0.72,
                  slideDistance: 92,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.sky600,
                                const Color(0xFF6366F1),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.sky600.withOpacity(0.30),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _runCode,
                            icon:
                                const Icon(Icons.play_arrow_rounded, size: 21),
                            label: const Text(
                              'Jalankan Kode',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _resetCode,
                        child: GlassMorphismBox(
                          borderRadius: 999,
                          opacity: 0.56,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.refresh_rounded,
                                size: 18,
                                color: AppColors.slate700,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _staggerSlide(
                  start: 0.34,
                  end: 0.88,
                  slideDistance: 102,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility_rounded,
                                  size: 16,
                                  color: AppColors.sky600,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Live Preview',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.slate800,
                                  ),
                                ),
                              ],
                            ),
                            GlassMorphismBox(
                              borderRadius: 999,
                              opacity: 0.55,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 3,
                              ),
                              boxShadow: const [],
                              child: Text(
                                'OUTPUT REALTIME',
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.sky700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GlassMorphismBox(
                        borderRadius: 28,
                        opacity: 0.48,
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Container(
                            height: 320,
                            color: Colors.white,
                            child: InAppWebView(
                              initialData: InAppWebViewInitialData(
                                data: _buildDocument(),
                              ),
                              initialSettings: InAppWebViewSettings(
                                isInspectable: true,
                                javaScriptEnabled: true,
                                mixedContentMode:
                                    MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                              ),
                              onWebViewCreated: (controller) {
                                _webViewController = controller;
                                if (!kIsWeb) {
                                  controller.addJavaScriptHandler(
                                    handlerName: 'onJsAlert',
                                    callback: (args) {
                                      final msg = args.isNotEmpty
                                          ? args.first.toString()
                                          : '';
                                      _showGlassAlert(msg);
                                    },
                                  );
                                }
                              },
                              onJsAlert: (controller, jsAlertRequest) async {
                                _showGlassAlert(jsAlertRequest.message ?? '');
                                return JsAlertResponse(handledByClient: true);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiquidTabSwitcher() {
    final tabs = _tabs;
    final count = tabs.length;

    return SizedBox(
      height: 50,
      child: GlassMorphismBox(
        borderRadius: 999,
        opacity: 0.46,
        padding: const EdgeInsets.all(4),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / count;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: (details) {
                final localX = details.localPosition.dx
                    .clamp(0.0, constraints.maxWidth - 1);
                setState(() {
                  _dragTab = (localX / itemWidth) - 0.5;
                });
              },
              onHorizontalDragEnd: (_) {
                if (_dragTab != null) {
                  _selectTab(_dragTab!.round());
                }
              },
              onHorizontalDragCancel: () {
                setState(() => _dragTab = null);
              },
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  end: _dragTab ?? _activeTab.toDouble(),
                ),
                duration: _dragTab != null
                    ? Duration.zero
                    : const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                builder: (context, animatedPos, _) {
                  final clampedPos =
                      animatedPos.clamp(0.0, (count - 1).toDouble());
                  final highlightedIndex = clampedPos.round();
                  final activeColor = tabs[highlightedIndex].accent;

                  return Stack(
                    children: [
                      Positioned(
                        left: clampedPos * itemWidth,
                        top: 0,
                        bottom: 0,
                        width: itemWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                activeColor.withOpacity(0.24),
                                activeColor.withOpacity(0.10),
                              ],
                            ),
                            border: Border.all(
                              color: AppColors.glassBorder,
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: activeColor.withOpacity(0.18),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          children: List.generate(count, (index) {
                            final tab = tabs[index];
                            final isHighlighted = highlightedIndex == index;

                            return Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _selectTab(index),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      tab.icon,
                                      size: 18,
                                      color: isHighlighted
                                          ? tab.accent
                                          : AppColors.slate600,
                                    ),
                                    const SizedBox(width: 6),
                                    AnimatedDefaultTextStyle(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isHighlighted
                                            ? tab.accent
                                            : AppColors.slate700,
                                        fontWeight: isHighlighted
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                      ),
                                      child: Text(tab.label),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}