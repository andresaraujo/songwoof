library songwoof.common.soundcloud.soundcloud_config;

import 'package:angular2/angular2.dart';

@Injectable()
class SoundCloudConfig {
  final String CLIENT_ID;
  final SOUND_CLOUD_BASE = 'http://api.soundcloud.com';

  const SoundCloudConfig(this.CLIENT_ID);
}
