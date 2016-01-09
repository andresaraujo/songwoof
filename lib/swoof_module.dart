library songwoof.module;

import 'dart:html' as html;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:http/browser_client.dart';
import 'package:firebase/firebase.dart';

import 'package:songwoof/common/soundcloud/soundcloud_config.dart';
import 'package:songwoof/common/soundcloud/soundcloud_interop.dart';
import 'package:songwoof/common/models/user_data.dart';

export 'swoof_app.dart';

class SWoofModule {
  final SoundCloudConfig soundCloudConfig;

  SWoofModule(this.soundCloudConfig);

  get providers {
    UserData userData = new UserData();

    Firebase firebase = new Firebase('https://songwoof.firebaseio.com/');
    firebase.onAuth().listen((authJson) {
      if (authJson != null) {
        userData.uid = authJson['uid'];
        userData.displayName = authJson['github']['displayName'];
      }
    });
    return [
      ROUTER_PROVIDERS,
      provide(APP_BASE_HREF, useValue: html.window.location.pathname),
      provide(LocationStrategy, useClass: HashLocationStrategy),
      provide(BrowserClient, useValue: new BrowserClient()),
      provide(SoundCloudConfig, useValue: soundCloudConfig),
      provide(SoundCloudAudio,
          useValue: new SoundCloudAudio(soundCloudConfig.CLIENT_ID)),
      provide(Firebase, useValue: firebase),
      provide(UserData, useValue: userData)
    ];
  }
}
