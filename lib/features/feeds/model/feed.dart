import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mood_tracker/core/model/emotion.dart';

class Feed {
  final String? id;
  final String content;
  final DateTime createAt;
  final Emotion emotion;

  Feed({
    this.id,
    required this.content,
    required this.createAt,
    required this.emotion,
  });

  factory Feed.fromJSON(Map<String, Object> map) => Feed(
        id: map['id'] as String,
        content: map['content'] as String,
        createAt: (map['create_at'] as Timestamp).toDate(),
        emotion: Emotion.fromString(map['emotion'] as String),
      );

  Map<String, dynamic> toJSON() {
    return {
      'content': content,
      'create_at': createAt,
      'emotion': emotion.toString(),
    };
  }
}
