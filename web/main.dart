import 'package:angular2/platform/browser.dart';
import 'package:songwoof/swoof_module.dart';
import 'package:songwoof/common/soundcloud/soundcloud_config.dart';
import 'dart:js' as js;

main() async {
  var songwoofModule =
      new SWoofModule(new SoundCloudConfig('0e790e28fcdf924f78f80375ad74fcb8'));


  bootstrap(SWoofApp, await songwoofModule.providers).then((_) {

    // Initialize mdl components
    var mdlHandler = new js.JsObject.fromBrowserObject(js.context['componentHandler']);
    mdlHandler.callMethod('upgradeAllRegistered');
  });
}
