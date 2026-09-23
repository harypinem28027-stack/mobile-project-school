// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_project/main.dart';

void main() {
  testWidgets('menampilkan halaman login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Masuk Akun Siswa'), findsOneWidget);
    expect(find.text('Masuk ke Modul Siswa'), findsOneWidget);
  });

  testWidgets('menolak login tanpa data', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final loginButton = find.text('Masuk ke Modul Siswa');
    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('NISN/Email dan kata sandi wajib diisi.'), findsOneWidget);
  });

  testWidgets('berhasil login dengan data lengkap', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'siswa@example.com');
    await tester.enterText(fields.at(1), 'password123');
    final loginButton = find.text('Masuk ke Modul Siswa');
    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Berhasil masuk!'), findsOneWidget);
  });
}
