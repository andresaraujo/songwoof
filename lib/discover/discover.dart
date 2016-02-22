library songwoof.discover;

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:songwoof/common/services/user_service.dart';
import 'package:songwoof/common/components/playlist/playlist.dart';
import 'package:songwoof/common/components/cover/cover.dart';
import 'package:songwoof/common/components/md_icon/md_icon.dart';
import 'package:songwoof/common/components/player/player.dart';
import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/models/track.dart';
import 'package:songwoof/common/soundcloud/soundcloud_api.dart';

@Component(
    selector: 'swoof-discover',
    templateUrl: 'discover.html',
    directives: const [
      SwoofPlayerComponent,
      PlaylistComponent,
      CoverComponent,
      MdIconComponent
    ],
    providers: const [
      SoundCloudApi,
      UserService
    ])
class DiscoverComponent implements OnInit, OnActivate {
  final Router _router;
  final UserData _userData;
  final SoundCloudApi _api;
  final UserService _userService;

  Track currentTrack;
  List<Track> trackList;

  Map<String, String> _params = {};

  DiscoverComponent(this._api, this._userService, this._router, this._userData,
      RouteParams params) {
    _params['tags'] = params.get('tags');
    _params['from'] = params.get('from');
  }

  void onTrackSelected(track) {
    currentTrack = track;
  }

  void togglePlay(bool isPaused) {
    // do nothing
  }

  void dismiss(Track track) {
    // do nothing
  }

  Future addToUserFavorites(Track track) async {
    await _userService.addToFavorites(currentTrack);
    int nextIndex = trackList.indexOf(track) + 1;

    if (nextIndex < trackList.length) {
      currentTrack = trackList.elementAt(nextIndex);
    }
  }

  void onTrackChange(Track track) {
    currentTrack = track;
  }

  @override
  ngOnInit() async {
    trackList = await _api.tracks(tags: _params['tags'], from: _params['from']);
    currentTrack = trackList[0];
  }

  @override
  routerOnActivate(ComponentInstruction next, ComponentInstruction prev) {
    if (!_userData.isAuthenticated()) {
      _router.navigate(['Login']);
    }
  }
}
