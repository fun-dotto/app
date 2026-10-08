import 'package:dotto/presentation/announcement/announcement_list_tile.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class AnnouncementScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcements = ref.watch(announcementStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: switch (announcements) {
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: ref.read(announcementStateProvider.notifier).refresh,
          child: ListView.separated(
            itemCount: value.length,
            separatorBuilder: (_, _) => const Divider(height: 0),
            itemBuilder: (_, index) =>
                AnnouncementListTile(announcement: value[index]),
          ),
        ),
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}
