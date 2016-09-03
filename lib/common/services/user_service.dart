import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:firebase3/firebase.dart' as firebase;

import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/models/track.dart';
import 'package:songwoof/swoof_module.dart';

@Injectable()
class UserService {
  final SongwoofDb _db;
  final SongwoofAuth _auth;
  final UserData _userData;
  UserService(this._db, this._userData, this._auth) {
    _auth.onAuthStateChanged.listen((event) => _loadUserData(event.user));
  }

  Future<Null> addToFavorites(Track track) {
    var c = new Completer();
    if (_userData.uid != null) {
      _favsRef().push(track.toMap()).future.then((v) => c.complete());
    } else {
      c.completeError('Cant\'t add to favs: User is not logged in');
    }

    return c.future;
  }

  Future<List<Track>> getFavoriteTracks() {
    return _favsRef().once('value').then(_transtormToModels);
  }

  List<Track> _transtormToModels(firebase.QueryEvent event) {
    return (event.snapshot.val() as Map).keys.map((k) {
      var v = event.snapshot.val()[k];
      v['fb_key'] = k;
      return new Track.fromMap(v);
    }).toList();
  }

  Future<firebase.User> login(String providerName) async {
    var provider = providerName == 'twitter' ? new firebase.TwitterAuthProvider() : new firebase.GithubAuthProvider();
    return _auth.signInWithPopup(provider).then((firebase.UserCredential result) {
      if (result != null) {
        _loadUserData(result.user);
        return result.user;
      }
    });
  }

  void logout() {
    _auth.signOut();
    _userData.uid = null;
    _userData.displayName = '';
  }

  _loadUserData(firebase.User user) {
    if (user != null) {
      _userData.uid = user.uid;
      _userData.displayName = user.providerData.first.displayName;
      return user;
    }
  }

  firebase.DatabaseReference _usersRef() => _db.ref('users');
  firebase.DatabaseReference _userRef() => _usersRef().child(_userData.uid);
  firebase.DatabaseReference _favsRef() => _userRef().child('favs');
}
