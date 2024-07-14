import 'package:flutter/material.dart';

enum Emotion {
  happy,
  sad,
  mad;

  static Emotion fromString(String kind) {
    return switch (kind) {
      "Happy" => Emotion.happy,
      "Sad" => Emotion.sad,
      "Mad" => Emotion.mad,
      _ => Emotion.happy
    };
  }

  Color toColor() {
    return switch (this) {
      Emotion.happy => Colors.amber,
      Emotion.sad => Colors.blueGrey,
      Emotion.mad => Colors.red,
    };
  }

  @override
  String toString() {
    return switch (this) {
      Emotion.happy => "Happy",
      Emotion.sad => "Sad",
      Emotion.mad => "Mad",
    };
  }
}
