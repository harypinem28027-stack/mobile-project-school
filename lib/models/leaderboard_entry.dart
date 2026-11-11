import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardEntry {
  final String uid;
  final String name;
  final int score;
  final String? photoUrl;

  const LeaderboardEntry({
    required this.uid,
    required this.name,
    required this.score,
    this.photoUrl,
  });

  factory LeaderboardEntry.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return LeaderboardEntry(
      uid: doc.id,
      name: (d['displayName'] as String?) ?? 'Pemain',
      score: (d['score'] as num?)?.toInt() ?? 0,
      photoUrl: d['photoUrl'] as String?,
    );
  }
}