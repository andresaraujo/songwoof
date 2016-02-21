import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:firebase/firebase.dart';

import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/models/track.dart';

@Injectable()
class UserService {
  final Firebase _firebase;
  final UserData _userData;
  UserService(this._firebase, this._userData);

  Future<Null> addToFavorites(Track track) {
    var c = new Completer();
    if (_userData.uid != null) {
      _favsRef().push(value: track.toMap(), onComplete: (v) => c.complete());
    } else {
      c.completeError('Cant\'t add to favs: User is not logged in');
    }

    return c.future;
  }

  Future<List<Track>> getFavoriteTracks() {
    return _favsRef().once('value').then(_transtormToModels);
  }

  List<Track> _transtormToModels(DataSnapshot ds) {
    return (ds.val() as Map).keys.map((k) {
      var v = ds.val()[k];
      v['fb_key'] = k;
      return new Track.fromMap(v);
    }).toList();
  }

  Future<Map> login(String provider) async {
    return _firebase.authWithOAuthPopup(provider).then((authJson) {
      if (authJson != null) {
        _userData.uid = authJson['uid'];
        _userData.displayName = authJson[provider]['displayName'];
        return authJson;
      }
    });
  }

  void logout() {
    _firebase.unauth();
    _userData.uid = null;
    _userData.displayName = '';
  }

  Firebase _usersRef() => _firebase.child('users');
  Firebase _userRef() => _usersRef().child(_userData.uid);
  Firebase _favsRef() => _userRef().child('favs');
}
