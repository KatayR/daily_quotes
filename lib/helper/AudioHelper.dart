import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  static AudioPlayer player = AudioPlayer();

  static playMusic() async {
    print("Before play: ${player.state}");
    player.setReleaseMode(ReleaseMode.loop);
    player.play(
      AssetSource(
        'sounds/testMusic.wav',
      ),
    );
    print("After play: ${player.state}");
  }

  static stopMusic() async {
    print("Before stop: ${player.state}");
    await player.stop();
    player.state = PlayerState.stopped;
    print("After stop: ${player.state}");
  }

  static dispose() async {
    await player.dispose();
  }
}
