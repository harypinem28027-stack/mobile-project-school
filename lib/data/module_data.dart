import 'package:flutter/material.dart';

import '../models/learning_module.dart';
import '../theme/app_colors.dart';

/// Data dummy modul pembelajaran. Nanti bisa diganti dengan hasil
/// fetch API tanpa mengubah widget/page manapun.
final List<LearningModule> kModules = [
  LearningModule(
    code: 'MOD-01 • HTML DASAR',
    idMateri: 'id_materi: MAT-01',
    category: 'html',
    categoryLabel: 'HTML Dasar',
    icon: Icons.html_outlined,
    iconColor: AppColors.orange600,
    iconBg: AppColors.orange50,
    iconBorder: AppColors.orange100,
    level: 'Pemula',
    duration: '15 mnt',
    title: 'Mengenal Kerangka Web (Tag <h1>, <p>, <a>, <img>)',
    description:
        'Belajar struktur fondasi halaman web, menyusun heading judul, paragraf teks, tautan link, dan menampilkan gambar.',
    bugIcon: Icons.bug_report_outlined,
    bugIconColor: AppColors.rose400,
    bugTextColor: AppColors.rose300,
    bugSnippet: '<h1>Halo Dunia // lupa tag penutup </h1>',
    caseCount: '6 Kasus',
    quizCount: 'KUIS_TIK: 4 Soal',
    labCount: 'LAB_PRAKTIK: 2 Sesi',
  ),
  LearningModule(
    code: 'MOD-02 • CSS DASAR',
    idMateri: 'id_materi: MAT-02',
    category: 'css',
    categoryLabel: 'CSS Dasar',
    icon: Icons.palette_outlined,
    iconColor: AppColors.sky600,
    iconBg: AppColors.sky50,
    iconBorder: AppColors.sky100,
    level: 'Pemula',
    duration: '20 mnt',
    title: 'Memberi Warna & Gaya Tampilan (Color, Font, Background)',
    description:
        'Mempercantik tampilan web sederhana dengan mengatur warna teks, ukuran font tulisan, serta latar belakang warna elemen.',
    bugIcon: Icons.warning_amber_outlined,
    bugIconColor: AppColors.amber300,
    bugTextColor: AppColors.amber300,
    bugSnippet: 'collor: red; // typo: seharusnya color: red;',
    caseCount: '5 Kasus',
    quizCount: 'KUIS_TIK: 5 Soal',
    labCount: 'LAB_PRAKTIK: 2 Sesi',
  ),
  LearningModule(
    code: 'MOD-03 • JS DASAR',
    idMateri: 'id_materi: MAT-03',
    category: 'js',
    categoryLabel: 'JavaScript Dasar',
    icon: Icons.javascript_outlined,
    iconColor: AppColors.amber700,
    iconBg: AppColors.amber50,
    iconBorder: AppColors.amber100,
    level: 'Pemula',
    duration: '25 mnt',
    title: 'Interaksi Tombol Sederhana & alert()',
    description:
        'Membuat website menjadi interaktif dengan menangani klik tombol untuk memunculkan pesan pop-up alert sederhana bagi pengguna.',
    bugIcon: Icons.error_outline,
    bugIconColor: AppColors.rose400,
    bugTextColor: AppColors.rose300,
    bugSnippet: 'alert "Halo Siswa!" // SyntaxError: kurung hilang',
    caseCount: '7 Kasus',
    quizCount: 'KUIS_TIK: 5 Soal',
    labCount: 'LAB_PRAKTIK: 2 Sesi',
  ),
];

const List<CategoryPill> kCategoryPills = [
  CategoryPill(label: 'Semua', value: 'all'),
  CategoryPill(label: 'HTML Dasar', value: 'html'),
  CategoryPill(label: 'CSS Dasar', value: 'css'),
  CategoryPill(label: 'JavaScript Dasar', value: 'js'),
];
