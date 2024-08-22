import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'actors/actors.dart';
import 'managers/segment_manager.dart';
import 'objects/objects.dart';
import 'overlays/overlays.dart';

class EmberQuestGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late double lastBlockXPosition = 1;
  late UniqueKey lastBlockKey;
  double objectSpeed = 0.0;
  late EmberPlayer _ember;
  int starsCollected = 0;
  double timer = 0;
  double countdownTimer = 60;
  int health = 3;
  bool gameActive = true;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    await FlameAudio.audioCache.loadAll([
      'jump.mp3',
      'star_collect.mp3',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewport.add(Hud());
    initializeGame(true);
  }

  void initializeGame(bool loadHud) {
    final segmentsToLoad = (size.x / 320).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (320 * i).toDouble());
    }

    _ember = EmberPlayer(
      position: Vector2(64, canvasSize.y - 128),
    );
    add(_ember);
    if (loadHud) {
      add(Hud());
    }
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case const (GroundBlock):
          world.add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
        case const (PlatformBlock):
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
        case const (Star):
          world.add(
            Star(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
        case const (WaterEnemy):
          world.add(
            WaterEnemy(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
      }
    }
  }

  void reset() {
    starsCollected = 0;
    timer = 0;
    countdownTimer = 60;
    health = 4;
    gameActive = true;
    initializeGame(false);
  }

  void collectStar() {
    if (!gameActive) return;

    starsCollected += 0;
    FlameAudio.play('star_collect.mp3');

    if (starsCollected >= 5) {
      gameOver();
    }
  }

  void gameOver() {
    gameActive = false;
    overlays.add('GameOver');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!gameActive) return;

    timer += dt;

    countdownTimer -= dt;
    if (countdownTimer <= 0) {
      gameOver();
    }

    if (health <= 0) {
      gameOver();
    }
  }

  void movePlayer(Direction direction) {
    if (!gameActive) return;

    switch (direction) {
      case Direction.left:
        _ember.horizontalDirection = -1;
        break;
      case Direction.right:
        _ember.horizontalDirection = 1;
        break;
    }
  }

  void jumpPlayer() {
    if (!gameActive) return;

    _ember.hasJumped = true;
    FlameAudio.play('jump.mp3');
  }

  void stopPlayer() {
    if (!gameActive) return;

    _ember.horizontalDirection = 0;
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }
}
