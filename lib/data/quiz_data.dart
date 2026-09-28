import 'package:flutter/material.dart';

import '../models/code_line.dart';
import '../models/quiz.dart';
import '../theme/app_colors.dart';

/// Data dummy kuis. Sama seperti data lain di project ini — widget/halaman
/// hanya bergantung pada model QuizModule/QuizQuestion, jadi file ini
/// gampang diganti hasil fetch API nanti.
final List<QuizModule> kQuizModules = [
  // ---------------- Kuis 01: HTML Dasar (selesai, nilai bagus) ----------------
  QuizModule(
    materialId: 'MAT-HTML-01',
    title: 'Kuis Modul 01: HTML Dasar',
    accentColor: AppColors.orange600,
    status: QuizStatus.completed,
    score: 95,
    correctCount: 4,
    totalQuestions: 4,
    estimatedMinutes: 5,
    kkmPercent: 75,
    topicLabel: 'Cakupan Tag Sintaks:',
    topicChips: const ['<h1>', '<p>', '<button>', '<a>'],
    topicNote: '& Tag Penutup Berpasangan',
    questions: [
      QuizQuestion(
        prompt: 'Tag HTML manakah yang digunakan untuk membuat heading paling besar?',
        options: const ['<h6>', '<h1>', '<head>', '<title>'],
        correctIndex: 1,
        explanation: '<h1> adalah tag heading dengan ukuran terbesar (h1 s/d h6, makin besar angka makin kecil ukurannya).',
      ),
      QuizQuestion(
        prompt: 'Manakah penulisan tag paragraf yang benar dan sudah tertutup?',
        codeFilename: 'index.html',
        codeSnippet: const [
          CodeLine(number: '1', text: '<p>Halo Dunia'),
        ],
        options: const [
          '<p>Halo Dunia',
          '<p>Halo Dunia</p>',
          '<p>Halo Dunia<p/>',
          '<paragraph>Halo Dunia</paragraph>',
        ],
        correctIndex: 1,
        explanation: 'Tag pembuka <p> harus punya pasangan tag penutup </p> agar struktur HTML valid.',
      ),
      QuizQuestion(
        prompt: 'Atribut apa yang dipakai pada tag <a> untuk menentukan tujuan tautan?',
        options: const ['src', 'href', 'link', 'to'],
        correctIndex: 1,
        explanation: 'Atribut href menentukan URL tujuan dari sebuah tautan <a>.',
      ),
      QuizQuestion(
        prompt: 'Tag apa yang dipakai untuk menampilkan gambar di halaman web?',
        options: const ['<image>', '<picture>', '<img>', '<src>'],
        correctIndex: 2,
        explanation: 'Tag <img> dipakai untuk menampilkan gambar, dengan atribut src sebagai sumber gambarnya.',
      ),
    ],
  ),

  // ---------------- Kuis 02: CSS Dasar (belum dikerjakan, wajib) ----------------
  QuizModule(
    materialId: 'MAT-CSS-02',
    title: 'Kuis Modul 02: CSS Dasar',
    accentColor: AppColors.sky600,
    status: QuizStatus.newChallenge,
    totalQuestions: 4,
    estimatedMinutes: 6,
    kkmPercent: 75,
    topicLabel: 'Target Analisis Debugging:',
    topicNote:
        "Selector class/id, warna heksadesimal, background-color, font-size, dan antisipasi typo sintaks CSS (misal 'collor').",
    questions: [
      QuizQuestion(
        prompt: 'Properti CSS mana yang benar untuk mengubah warna teks?',
        codeFilename: 'style.css',
        codeSnippet: const [
          CodeLine(number: '1', text: 'h1 {'),
          CodeLine(
            number: '2',
            text: '    collor: red;',
            type: CodeLineType.error,
            spans: [
              CodeSpan('collor', color: Color(0xFFFB7185), bold: true, underline: true),
              CodeSpan(': ', color: Colors.white),
              CodeSpan('red', color: Color(0xFFFDA4AF)),
              CodeSpan(';', color: Colors.white),
            ],
          ),
          CodeLine(number: '3', text: '}'),
        ],
        options: const ['collor', 'colour', 'color', 'text-colour'],
        correctIndex: 2,
        explanation: "Ejaan yang benar adalah 'color' (satu huruf 'l'), bukan 'collor' atau 'colour'.",
      ),
      QuizQuestion(
        prompt: 'Cara menulis warna heksadesimal biru murni yang benar adalah...',
        options: const ['#0000FF', '0000FF', 'blue-hex', '#BLUE'],
        correctIndex: 0,
        explanation: 'Warna heksadesimal di CSS selalu diawali tanda pagar (#), contoh #0000FF untuk biru murni.',
      ),
      QuizQuestion(
        prompt: 'Properti untuk mengatur warna latar belakang suatu elemen adalah...',
        options: const ['color', 'background-color', 'bg-color', 'fill-color'],
        correctIndex: 1,
        explanation: 'background-color dipakai untuk mengatur warna latar belakang elemen HTML.',
      ),
      QuizQuestion(
        prompt: 'Selector CSS manakah yang menargetkan elemen dengan id="judul"?',
        options: const ['.judul', '#judul', '*judul', '@judul'],
        correctIndex: 1,
        explanation: 'Selector id di CSS diawali tanda pagar (#), sedangkan class diawali titik (.).',
      ),
    ],
  ),

  // ---------------- Kuis 03: JS Dasar (perlu peningkatan) ----------------
  QuizModule(
    materialId: 'MAT-JS-03',
    title: 'Kuis Modul 03: JavaScript Dasar',
    accentColor: AppColors.amber700,
    status: QuizStatus.needsImprovement,
    score: 82,
    correctCount: 3,
    totalQuestions: 4,
    estimatedMinutes: 8,
    kkmPercent: 75,
    topicLabel: 'Materi Eksekusi Runtime:',
    topicChips: const ['alert()', 'onclick event'],
    topicNote: 'fungsi sederhana, sanitasi string & penutup kurung',
    questions: [
      QuizQuestion(
        prompt: 'Manakah kode JavaScript yang valid untuk menampilkan pesan pop-up?',
        codeFilename: 'script.js',
        codeSnippet: const [
          CodeLine(
            number: '1',
            text: 'alert("Halo;',
            type: CodeLineType.error,
          ),
        ],
        options: const [
          'alert("Halo);',
          'alert("Halo";',
          'alert("Halo");',
          'alert(Halo);',
        ],
        correctIndex: 2,
        explanation: 'String harus diapit tanda petik yang lengkap dan pemanggilan fungsi ditutup dengan kurung serta titik koma.',
      ),
      QuizQuestion(
        prompt: 'Event apa yang dipicu saat tombol diklik?',
        options: const ['onchange', 'onclick', 'onhover', 'onsubmit'],
        correctIndex: 1,
        explanation: 'onclick adalah event handler yang dijalankan ketika elemen (mis. tombol) diklik pengguna.',
      ),
      QuizQuestion(
        prompt: 'Bagaimana cara mendeklarasikan variabel di JavaScript modern?',
        options: const ['var x = 5', 'let x = 5', 'int x = 5', 'x := 5'],
        correctIndex: 1,
        explanation: "let (atau const) adalah cara deklarasi variabel yang disarankan di JavaScript modern.",
      ),
      QuizQuestion(
        prompt: 'Apa hasil dari kode berikut: console.log(2 + "2")?',
        options: const ['4', '"22"', 'Error', 'undefined'],
        correctIndex: 1,
        explanation: 'JavaScript akan menggabungkan (concat) angka dan string menjadi string "22" karena salah satu operand berupa string.',
      ),
    ],
  ),
];
