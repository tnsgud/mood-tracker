import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mood_tracker/features/feeds/view_model/feed_view_mode.dart';

import 'widgets/feed_card.dart';

class FeedsScreen extends ConsumerWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFeeds = ref.watch(feedsProvider);

    return asyncFeeds.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (data) {
        final feeds = groupBy(
          data,
          (feed) => feed.createAt.toString().substring(0, 7),
        ).entries.toList();

        return Container(
          color: Colors.black,
          child: ListView.separated(
            itemCount: feeds.length,
            itemBuilder: (context, index) => FeedCard(
              title: feeds[index].key,
              feeds: feeds[index].value,
            ),
            separatorBuilder: (context, index) => const Gap(10),
          ),
        );
      },
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
