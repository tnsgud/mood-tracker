import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mood_tracker/core/model/emotion.dart';
import 'package:mood_tracker/core/widget/custom_text_field.dart';
import 'package:mood_tracker/features/feeds/view_model/feed_view_mode.dart';

class PostingScreen extends ConsumerStatefulWidget {
  const PostingScreen({super.key});

  @override
  ConsumerState<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends ConsumerState<PostingScreen> {
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          CustomTextField(
            controller: _contentController,
            hintText: '오늘의 기분은 어떠신가요?',
          ),
          const Gap(20),
          GestureDetector(
            onTap: () {
              ref.watch(feedsProvider.notifier).addFeed(
                    content: _contentController.text,
                    emotion: Emotion.happy,
                  );
              FocusScope.of(context).unfocus();
              _contentController.clear();
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text('Posting'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
