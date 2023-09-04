import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

// for music
class MusicHelper {
  static AudioPlayer player = AudioPlayer();

  static playMusic() async {
    player.setReleaseMode(ReleaseMode.loop);
    // A Story Of Victory by Fatih Yasar - Royalty Free Music
    player.play(
      AssetSource(
        'sounds/music.mp3',
      ),
    );
  }

  static stopMusic() async {
    player.dispose();
    player = AudioPlayer();
    await player.stop();
    player.state = PlayerState.stopped;
  }

  static dispose() {
    player.dispose();
  }
}

// for sound effects, without delay
class EffectHelper {
  static Soundpool pool = Soundpool(streamType: StreamType.notification);

  static var soundId;

  static loadSound() async {
    pool = Soundpool(streamType: StreamType.notification);
    soundId = await rootBundle
        .load("assets/sounds/button.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    return soundId;
  }

  static playSound() async {
    int streamId = await pool.play(soundId);
  }
}
