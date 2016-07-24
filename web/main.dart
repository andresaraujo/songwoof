import 'package:angular2/platform/browser.dart';
import 'package:songwoof/swoof_module.dart';
import 'package:songwoof/common/soundcloud/soundcloud_config.dart';

void main() {
  var songwoofModule =
      new SWoofModule(new SoundCloudConfig('0e790e28fcdf924f78f80375ad74fcb8'));

  bootstrap(SWoofApp, songwoofModule.providers);
}
