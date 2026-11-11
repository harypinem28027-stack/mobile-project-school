import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/leaderboard_entry.dart';
import '../services/leaderboard_service.dart';
import '../widgets/main_scaffold.dart';

/// Halaman Leaderboard (tab index 4).
class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final _service = LeaderboardService();
  LeaderboardPeriod _period = LeaderboardPeriod.week;

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser?.uid;

    return MainScaffold(
      currentIndex: 4,
      headerSubtitle: 'Peringkat',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<LeaderboardPeriod>(
              segments: const [
                ButtonSegment(
                  value: LeaderboardPeriod.week,
                  label: Text('Mingguan'),
                ),
                ButtonSegment(
                  value: LeaderboardPeriod.month,
                  label: Text('Bulanan'),
                ),
                ButtonSegment(
                  value: LeaderboardPeriod.all,
                  label: Text('Semua'),
                ),
              ],
              selected: {_period},
              onSelectionChanged: (s) => setState(() => _period = s.first),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<LeaderboardEntry>>(
              stream: _service.topEntries(_period),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Leaderboard belum bisa dimuat.\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final entries = snapshot.data!;
                if (entries.isEmpty) {
                  return const Center(
                    child: Text('Belum ada skor. Kerjakan kuis dulu!'),
                  );
                }

                final top3 = entries.take(3).toList();
                final rest = entries.skip(3).toList();

                return Column(
                  children: [
                    _Podium(top3: top3, myUid: myUid),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView.builder(
                        itemCount: rest.length,
                        itemBuilder: (context, i) {
                          final e = rest[i];
                          final isMe = e.uid == myUid;
                          return ListTile(
                            tileColor: isMe
                                ? Theme.of(context).colorScheme.primaryContainer
                                : null,
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 28,
                                  child: Text(
                                    '${i + 4}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _Avatar(
                                  entry: e,
                                  radius: 20,
                                  color: Colors.blueGrey,
                                ),
                              ],
                            ),
                            title: Text(isMe ? '${e.name} (Kamu)' : e.name),
                            trailing: Text(
                              '${e.score}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.entry, required this.radius, this.color});

  final LeaderboardEntry entry;
  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final url = entry.photoUrl;
    final hasPhoto = url != null && url.isNotEmpty;
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      backgroundImage: hasPhoto ? NetworkImage(url) : null,
      child: hasPhoto
          ? null
          : Text(
              entry.name.isNotEmpty ? entry.name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium({required this.top3, required this.myUid});

  final List<LeaderboardEntry> top3;
  final String? myUid;

  @override
  Widget build(BuildContext context) {
    LeaderboardEntry? at(int i) => i < top3.length ? top3[i] : null;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PodiumSlot(entry: at(1), rank: 2, height: 90, myUid: myUid),
          _PodiumSlot(entry: at(0), rank: 1, height: 130, myUid: myUid),
          _PodiumSlot(entry: at(2), rank: 3, height: 70, myUid: myUid),
        ],
      ),
    );
  }
}

class _PodiumSlot extends StatelessWidget {
  const _PodiumSlot({
    required this.entry,
    required this.rank,
    required this.height,
    required this.myUid,
  });

  final LeaderboardEntry? entry;
  final int rank;
  final double height;
  final String? myUid;

  static const _colors = {
    1: Color(0xFFFFC107), // emas
    2: Color(0xFFB0BEC5), // perak
    3: Color(0xFFCD7F32), // perunggu
  };

  @override
  Widget build(BuildContext context) {
    final e = entry;
    final color = _colors[rank]!;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (e != null) ...[
            _Avatar(entry: e, radius: rank == 1 ? 30 : 24, color: color),
            const SizedBox(height: 6),
            Text(
              e.uid == myUid ? '${e.name} (Kamu)' : e.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text('${e.score}'),
            const SizedBox(height: 6),
          ],
          Container(
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$rank',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
