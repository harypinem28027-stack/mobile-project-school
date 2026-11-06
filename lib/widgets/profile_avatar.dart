import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

/// Avatar profil yang otomatis update saat UserProfile berubah.
class ProfileAvatar extends StatelessWidget {
  final double radius;
  const ProfileAvatar({super.key, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserProfile.instance,
      builder: (context, _) {
        final avatar = UserProfile.instance.avatar;
        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: avatar.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(avatar.icon, color: Colors.white, size: radius),
        );
      },
    );
  }
}

/// Teks nama profil yang otomatis update.
class ProfileName extends StatelessWidget {
  final TextStyle? style;
  final TextOverflow? overflow;
  const ProfileName({super.key, this.style, this.overflow});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserProfile.instance,
      builder: (context, _) =>
          Text(UserProfile.instance.name, style: style, overflow: overflow),
    );
  }
}

/// Teks email profil yang otomatis update.
class ProfileEmail extends StatelessWidget {
  final TextStyle? style;
  final TextOverflow? overflow;
  const ProfileEmail({super.key, this.style, this.overflow});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserProfile.instance,
      builder: (context, _) =>
          Text(UserProfile.instance.email, style: style, overflow: overflow),
    );
  }
}