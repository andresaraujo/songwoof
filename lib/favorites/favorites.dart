library songwoof.favorites;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/models/track.dart';
import 'package:songwoof/common/components/playlist/playlist.dart';
import 'package:songwoof/common/services/user_service.dart';

@Component(
    selector: 'swoof-favorites',
    templateUrl: 'favorites.html',
    directives: const [PlaylistComponent],
    providers: const [UserService])
class FavoritesComponent implements OnInit, OnActivate {
  final Router _router;
  final UserData _userData;
  final UserService _userService;

  List<Track> favorites;

  FavoritesComponent(this._router, this._userData, this._userService);

  @override
  ngOnInit() async {
    favorites = await _userService.getFavoriteTracks() ?? [];
    favorites = favorites.reversed;
  }

  @override
  routerOnActivate(ComponentInstruction next, ComponentInstruction prev) {
    if (!_userData.isAuthenticated()) {
      _router.navigate(['Login']);
    }
  }
}
