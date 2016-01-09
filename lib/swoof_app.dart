library songwoof.app;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/services/user_service.dart';
import 'package:songwoof/swoof_routes.dart';

@Component(
    selector: 'songwoof-app',
    templateUrl: 'swoof_app.html',
    directives: const [ROUTER_DIRECTIVES, NgClass, NgStyle],
    providers: const [UserService])
@RouteConfig(SWOOF_ROUTES)
class SWoofApp {
  bool isDarkTheme = false;
  String currentRoute;
  final UserData userData;

  final UserService _userService;
  final Router _router;

  SWoofApp(this._router, this._userService, this.userData) {
    _router.subscribe((String next) => currentRoute = next);
  }

  void navigate(String componentName) {
    _router.navigate([componentName]);
  }

  bool hideMenuItem(String menu) {
    return menu == currentRoute || currentRoute == 'login';
  }

  void logout() {
    _userService.logout();
    _router.navigate(['Login']);
  }

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
  }
}
