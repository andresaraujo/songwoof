library songwoof.common.services.user_data;

import 'package:angular2/angular2.dart';

@Injectable()
class UserData {
  String uid;
  String displayName;

  bool isAuthenticated() => uid != null;
}
