library songwoof.login;

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/services/user_service.dart';

@Component(
    selector: 'swoof-login',
    templateUrl: 'login.html',
    providers: const [UserService])
class LoginComponent implements OnActivate {
  final Router _router;
  final UserService _userService;
  final UserData _userData;

  LoginComponent(this._router, this._userService, this._userData);

  Future login(String provider) async {
    await _userService.login(provider);
    _router.navigate(['Home']);
  }

  @override
  routerOnActivate(ComponentInstruction next, ComponentInstruction prev) {
    if (_userData.isAuthenticated()) {
      _router.navigate(['Home']);
    }
  }
}
