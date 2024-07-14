import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mood_tracker/core/constants/text_style.dart';
import 'package:mood_tracker/features/feeds/view_model/feed_view_mode.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../model/feed.dart';

class FeedCard extends ConsumerWidget {
  const FeedCard({super.key, required this.title, required this.feeds});

  final String title;
  final List<Feed> feeds;

  void _showActionSheet(BuildContext context, WidgetRef ref, String id) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text(
          '기록을 삭제하시겠습니까?',
          style: system01,
        ),
        message: const Text(
          '삭제된 기록은 복구가 불가능합니다.',
          style: system05,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              ref.watch(feedsProvider.notifier).removeFeed(id);
            },
            child: Text(
              '삭제',
              style: system06.copyWith(color: Colors.red),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              '취소',
              style: system06,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StickyHeader(
      header: Container(
        width: double.infinity,
        color: Colors.black,
        child: Text(title, style: system01),
      ),
      content: SizedBox(
        height: feeds.length * 65,
        child: ListView.separated(
          itemCount: feeds.length,
          itemBuilder: (context, index) => GestureDetector(
            onLongPress: () => _showActionSheet(context, ref, feeds[index].id!),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: feeds[index].emotion.toColor(), width: 4),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${feeds[index].createAt.day}일',
                    style: system01.copyWith(color: Colors.black),
                  ),
                  const Gap(10),
                  Text(
                    feeds[index].content,
                    style: system08.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Gap(5),
        ),
      ),
    );
  }
}
