import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/core/model/emotion.dart';

import '../model/feed.dart';

class FeedsViewModel extends AsyncNotifier<List<Feed>> {
  final _user = FirebaseAuth.instance.currentUser!;
  late final _collection =
      FirebaseFirestore.instance.collection(_user.email ?? '');

  @override
  FutureOr<List<Feed>> build() async {
    return _loadFeeds();
  }

  Future<List<Feed>> _loadFeeds() async {
    final data = await _collection.orderBy('create_at', descending: true).get();

    final list = data.docs.map((e) {
      return Feed.fromJSON({
        'id': e.id,
        ...e.data(),
      });
    }).toList();

    return list;
  }

  Future<void> addFeed({
    required String content,
    required Emotion emotion,
  }) async {
    state = const AsyncValue.loading();

    final feed = Feed(
      content: content,
      emotion: emotion,
      createAt: DateTime.now(),
    );

    await _collection.add(feed.toJSON());

    state = await AsyncValue.guard(() => _loadFeeds());
  }

  Future<void> removeFeed(String id) async {
    state = const AsyncValue.loading();

    await _collection.doc(id).delete();

    state = await AsyncValue.guard(() => _loadFeeds());
  }
}

final feedsProvider = AsyncNotifierProvider<FeedsViewModel, List<Feed>>(
  FeedsViewModel.new,
);
