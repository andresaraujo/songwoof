library songwoof.common.soundcloud.soundcloud_player;

import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:js/js.dart' as js;
import 'package:songwoof/common/models/track.dart';
import 'package:songwoof/common/soundcloud/soundcloud_interop.dart';

@Injectable()
class SoundCloudPlayer {
  final SoundCloudAudio _scAudio;
  final StreamController _onEndedController = new StreamController.broadcast();
  Stream get onEnded => _onEndedController.stream;

  SoundCloudPlayer(this._scAudio) {
    _scAudio.on('ended', js.allowInterop(_onEnded));
  }

  void play(Track track) {
    print('Playing $track');
    _scAudio.play(new Options(streamUrl: track.streamUrl));
  }

  void stop() {
    _scAudio.stop();
  }

  void pause() {
    _scAudio.pause();
  }

  bool isPlaying() {
    if (_scAudio.playing is bool) {
      return false;
    } else {
      return true;
    }
  }

  void _onEnded(audio) {
    _onEndedController.add(audio);
  }
}
