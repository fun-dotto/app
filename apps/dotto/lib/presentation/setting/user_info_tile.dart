import 'package:dotto/domain/dotto_user.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

final class UserInfoTile extends StatelessWidget {
  const new({this.user, super.key, this.onTap, this.isLoading = false});

  /// 表示するユーザー。未ログインの場合は `null`。
  final DottoUser? user;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final photoUrl = _nonEmpty(user?.avatarUrl);
    final name = _nonEmpty(user?.name) ?? 'ログイン';
    final email = switch (_nonEmpty(user?.email)) {
      final String email => '$emailでログイン中',
      null => 'Google アカウント (@fun.ac.jp) でログイン',
    };

    return Material(
      color: SemanticColor.light.backgroundSecondary,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            spacing: 12,
            children: [
              if (isLoading)
                const _Skeleton(width: 44, height: 44, shape: BoxShape.circle)
              else
                _Avatar(photoUrl: photoUrl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isLoading
                      ? const [
                          _Skeleton(width: 120, height: 16),
                          SizedBox(height: 8),
                          _Skeleton(width: 220, height: 14),
                        ]
                      : [
                          Text(
                            name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            email,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: SemanticColor.light.labelSecondary,
                                ),
                          ),
                        ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: SemanticColor.light.labelSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String? _nonEmpty(String? value) => switch (value?.trim()) {
    final String trimmed when trimmed.isNotEmpty => trimmed,
    _ => null,
  };
}

final class _Avatar extends StatelessWidget {
  const new({required this.photoUrl});

  static const _size = 48.0;

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: SemanticColor.light.borderPrimary),
      ),
      child: ClipOval(
        child: SizedBox(
          width: _size,
          height: _size,
          child: switch (photoUrl) {
            final String url => Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(Icons.person),
            ),
            null => const Icon(Icons.person),
          },
        ),
      ),
    );
  }
}

final class _Skeleton extends StatelessWidget {
  const new({
    required this.width,
    required this.height,
    this.shape = BoxShape.rectangle,
  });

  final double width;
  final double height;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(8),
          shape: shape,
        ),
      ),
    );
  }
}
