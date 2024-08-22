import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:n11game/ember_quest.dart';

class GameTimer extends TextComponent with HasGameReference<EmberQuestGame> {
  GameTimer({
    super.position,
    super.size,
    super.anchor,
    super.priority = 1,
  }) : super(
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    game.timer += dt;
    text = _getFormattedTime(game.timer);
  }

  String _getFormattedTime(double elapsedTime) {
    final int minutes = (elapsedTime ~/ 60);
    final int seconds = (elapsedTime % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
