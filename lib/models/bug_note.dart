/// Satu catatan bug di "Buku Catatan Bug" halaman Progres.
class BugNote {
  final String category; // html | css | js
  final String categoryLabel; // "HTML DASAR"
  final String materialId; // id_materi: HTML-01
  final String quizId; // id_kuis: KUIS-01
  final String date; // "20 Apr, 14:15"
  final String title;
  final String filename; // index.html / style.css / script.js
  final String wrongCode;
  final String correctCode;
  final String solutionText;

  const BugNote({
    required this.category,
    required this.categoryLabel,
    required this.materialId,
    required this.quizId,
    required this.date,
    required this.title,
    required this.filename,
    required this.wrongCode,
    required this.correctCode,
    required this.solutionText,
  });
}
