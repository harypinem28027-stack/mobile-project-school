import '../models/bug_note.dart';

/// Data dummy catatan bug di Buku Catatan Bug (halaman Progres).
final List<BugNote> kBugNotes = [
  BugNote(
    category: 'html',
    categoryLabel: 'HTML DASAR',
    materialId: 'id_materi: HTML-01',
    quizId: 'id_kuis: KUIS-01',
    date: '20 Apr, 14:15',
    title: 'HTML Dasar: Lupa menutup tag <h1>',
    filename: 'index.html',
    wrongCode: '✕ <h1>Judul Halaman Web',
    correctCode: '✓ <h1>Judul Halaman Web</h1>',
    solutionText:
        "Selalu pasang pasangan penutup </h1> agar format heading tidak berlanjut ke paragraf di bawahnya.",
  ),
  BugNote(
    category: 'css',
    categoryLabel: 'CSS DASAR',
    materialId: 'id_materi: CSS-01',
    quizId: 'id_kuis: KUIS-04',
    date: '19 Apr, 09:30',
    title: "CSS Dasar: Salah ejaan properti 'collor'",
    filename: 'style.css',
    wrongCode: '✕ p { collor: red; }',
    correctCode: '✓ p { color: red; }',
    solutionText:
        "Gunakan ejaan resmi color: biru/merah tanpa huruf ganda 'l' agar browser mengenali gaya warna teks.",
  ),
  BugNote(
    category: 'js',
    categoryLabel: 'JS / LOGIKA DASAR',
    materialId: 'id_materi: JS-01',
    quizId: 'id_kuis: KUIS-06',
    date: '17 Apr, 16:40',
    title: 'JS / Logika Dasar: Tanda petik kurang pada alert',
    filename: 'script.js',
    wrongCode: '✕ alert("Halo); // SyntaxError',
    correctCode: '✓ alert("Halo"); // Diapit petik ganda berpasangan',
    solutionText:
        'Penulisan teks string seperti alert("Halo") harus diapit tanda petik pembuka dan penutup secara lengkap.',
  ),
];
