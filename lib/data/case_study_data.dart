import 'package:flutter/material.dart';

import '../models/case_study.dart';

/// Data dummy studi kasus. Sama seperti module_data.dart, file ini yang
/// paling gampang diganti API nanti — widget/halaman lain hanya
/// bergantung pada model CaseStudy, bukan ke file ini.
final CaseStudy kCssTypoCaseStudy = CaseStudy(
  caseNumber: 'CASE STUDY #01',
  materialId: 'id_materi: CSS-01',
  labId: 'id_lab: LAB-01',
  errorTag: 'CSS Syntax Error: Typo',
  title: 'Bedah Kasus Sederhana #01: Teks Tidak Berwarna Merah (CSS Typo)',
  subject: 'CSS Dasar',
  level: 'Tingkat: Pemula',
  targetClass: 'Kelas X / Siswa Baru',
  problemScenario:
      'Siswa ingin mengubah warna teks judul menjadi merah menggunakan CSS, '
      'tetapi teks tetap berwarna hitam.',
  brokenFilename: 'style.broken.css',
  brokenCode: const [
    CodeLine(number: '1', text: 'h1 {'),
    CodeLine(
      number: '2',
      text: '    collor: red;',
      type: CodeLineType.error,
      spans: [
        CodeSpan('collor',
            color: Color(0xFFFB7185),
            bold: true,
            underline: true),
        CodeSpan(': ', color: Colors.white),
        CodeSpan('red', color: Color(0xFFFDA4AF)),
        CodeSpan(';', color: Colors.white),
      ],
    ),
    CodeLine(number: '3', text: '}'),
  ],
  errorDiagnosisTitle: 'Diagnosis Kesalahan CSS',
  errorDiagnosisText:
      "⚠️ Properti 'collor' tidak dikenali oleh browser.",
  fixedFilename: 'style.fixed.css',
  fixedCode: const [
    CodeLine(number: '1', text: 'h1 {'),
    CodeLine(
      number: '2',
      text: '    color: red;',
      type: CodeLineType.success,
      spans: [
        CodeSpan('color', color: Color(0xFF34D399), bold: true),
        CodeSpan(': ', color: Colors.white),
        CodeSpan('red', color: Color(0xFF7DD3FC)),
        CodeSpan(';', color: Colors.white),
      ],
    ),
    CodeLine(number: '3', text: '}'),
  ],
  successText: 'Berhasil! Teks judul kini berwarna merah cerah.',
  wrongSnippet: 'h1 {\n  collor: red;\n}',
  correctSnippet: 'h1 {\n  color: red;\n}',
  comparisonTip: 'Gunakan "color", bukan "collor".',
  teacherId: 'id_guru: GRU-01',
  teacherName: 'Bpk. Hendra Pratama, S.Kom',
  teacherTipsTitle: 'Tips Dasar Guru TIK',
  teacherTipsText:
      "CSS sangat teliti dengan ejaan bahasa Inggris. Pastikan menulis "
      "'color' dengan satu huruf 'l'. Penulisan 'collor' akan diabaikan "
      "otomatis oleh web browser.",
);

/// List semua studi kasus (baru ada 1, tinggal tambah item baru di sini).
final List<CaseStudy> kCaseStudies = [kCssTypoCaseStudy];
