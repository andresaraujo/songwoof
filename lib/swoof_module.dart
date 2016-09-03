library songwoof.module;

import 'dart:async';
import 'dart:html' as html;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';
import 'package:http/browser_client.dart';
import 'package:firebase3/firebase.dart' as firebase;

import 'package:songwoof/common/soundcloud/soundcloud_config.dart';
import 'package:songwoof/common/soundcloud/soundcloud_interop.dart';
import 'package:songwoof/common/models/user_data.dart';

export 'swoof_app.dart';

class SWoofModule {
  final SoundCloudConfig soundCloudConfig;

  SWoofModule(this.soundCloudConfig);

  Future<dynamic> get providers async {
    UserData userData = new UserData();

    firebase.initializeApp(
        apiKey: "AIzaSyBG5CkMSYLU_OYwO6seCMcC5YyjF0aIfUE",
        authDomain: "songwoof.firebaseapp.com",
        databaseURL: "https://songwoof.firebaseio.com",
        storageBucket: "songwoof.appspot.com");

    firebase.Database rootRef = firebase.database();
    firebase.Auth auth = firebase.auth();

    firebase.AuthEvent authEvent = await auth.onAuthStateChanged.first;

    if (authEvent?.user != null) {
      userData.uid = authEvent.user.uid;
      userData.displayName = authEvent.user.providerData.first.displayName;
    }

    return [
      ROUTER_PROVIDERS,
      provide(APP_BASE_HREF, useValue: html.window.location.pathname),
      //provide(LocationStrategy, useClass: HashLocationStrategy),
      provide(BrowserClient, useValue: new BrowserClient()),
      provide(SoundCloudConfig, useValue: soundCloudConfig),
      provide(SoundCloudAudio,
          useValue: new SoundCloudAudio(soundCloudConfig.CLIENT_ID)),
      provide(SongwoofDb, useValue: rootRef),
      provide(SongwoofAuth, useValue: auth),
      provide(UserData, useValue: userData)
    ];
  }
}

@Injectable()
class SongwoofAuth extends firebase.Auth {
  SongwoofAuth.fromJsObject(jsObject) : super.fromJsObject(jsObject);}

@Injectable()
class SongwoofDb extends firebase.Database {
  SongwoofDb.fromJsObject(jsObject) : super.fromJsObject(jsObject);}


