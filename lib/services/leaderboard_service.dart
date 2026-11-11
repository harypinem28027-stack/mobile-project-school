import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/leaderboard_entry.dart';
import 'auth_service.dart'; // sesuaikan path kalau AuthService ada di folder lain

enum LeaderboardPeriod { week, month, all }

String periodKey(LeaderboardPeriod p, [DateTime? now]) {
  final d = now ?? DateTime.now();
  String two(int n) => n.toString().padLeft(2, '0');
  switch (p) {
    case LeaderboardPeriod.week:
      final monday = d.subtract(Duration(days: d.weekday - 1));
      return 'week-${monday.year}-${two(monday.month)}-${two(monday.day)}';
    case LeaderboardPeriod.month:
      return 'month-${d.year}-${two(d.month)}';
    case LeaderboardPeriod.all:
      return 'all';
  }
}

/// Firestore: leaderboard_periods/{kunciPeriode}/entries/{uid}
class LeaderboardService {
  LeaderboardService({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _entries(String key) =>
      _db.collection('leaderboard_periods').doc(key).collection('entries');

  /// Pastikan ada user Firebase (anonim). Aman dipanggil berkali-kali.
  Future<User> ensureSignedIn() async {
    final auth = FirebaseAuth.instance;
    final current = auth.currentUser;
    if (current != null) return current;
    final cred = await auth.signInAnonymously();
    return cred.user!;
  }

  Stream<List<LeaderboardEntry>> topEntries(
    LeaderboardPeriod p, {
    int limit = 50,
  }) {
    return _entries(periodKey(p))
        .orderBy('score', descending: true)
        .limit(limit)
        .snapshots()
        .map((s) => s.docs.map(LeaderboardEntry.fromDoc).toList());
  }

  /// Tambah poin untuk siswa yang sedang login di aplikasi.
  Future<void> addPoints(int points) async {
    if (points <= 0) return;

    final user = await ensureSignedIn();
    final savedName = (await AuthService.getStudentName())?.trim();
    final name = (savedName == null || savedName.isEmpty) ? 'Siswa' : savedName;

    final batch = _db.batch();
    for (final p in LeaderboardPeriod.values) {
      batch.set(_entries(periodKey(p)).doc(user.uid), {
        'displayName': name,
        'score': FieldValue.increment(points),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
    await batch.commit();
  }

  /// Panggil saat kuis selesai. Hanya kenaikan nilai terbaik yang ditambahkan,
  /// jadi mengulang kuis tidak bisa menggandakan poin.
  Future<void> submitQuizResult({
    required String materialId,
    required int score,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'best_quiz_$materialId';
    final best = prefs.getInt(key) ?? 0;
    if (score <= best) return;

    await addPoints(score - best);
    await prefs.setInt(key, score); // disimpan hanya kalau addPoints berhasil
  }
}
