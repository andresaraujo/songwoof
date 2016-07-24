@JS()
library songwoof.common.soundcloud.soundcloud_interop;

//todo: Move to its own package
import 'package:js/js.dart';

/// Wrapper for https://github.com/voronianski/soundcloud-audio.js/
@JS("SoundCloudAudio")
class SoundCloudAudio {
  external SoundCloudAudio(String clientId);
  external play(Options);
  external stop();
  external pause();
  external on(String event, Function callback);
  external off(String event, Function callback);
  external unbindAll();
  external get playing;
}

@JS()
@anonymous
class Options {
  external factory Options({String streamUrl});
}
