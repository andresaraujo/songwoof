library songwoof.home;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/components/tag/tag.dart';

@Component(
    selector: 'swoof-home',
    templateUrl: 'home.html',
    directives: const [NgFor, NgClass, TagComponent])
class HomeComponent implements OnActivate {
  final Router _router;
  final UserData _userData;
  List<String> filterTags = [];

  final tags = DEFAULT_TAGS;

  HomeComponent(this._router, this._userData);

  void addTag(String tag) {
    if (filterTags.indexOf(tag) == -1) {
      filterTags.add(tag);
    } else {
      filterTags.remove(tag);
    }
  }

  void discover() {
    _router.navigate([
      'Discover',
      {'tags': filterTags.join(',')}
    ]);
  }

  bool isTagActive(String tag) {
    return filterTags.indexOf(tag) != -1;
  }

  @override
  routerOnActivate(ComponentInstruction next, ComponentInstruction prev) {
    if (!_userData.isAuthenticated()) {
      _router.navigate(['Login']);
    }
  }
}

const DEFAULT_TAGS = const [
  'chill',
  'indie',
  'love',
  'dnb',
  'electronic',
  'study',
  'alternative',
  'sad',
  'instrumental',
  'christmas',
  'kpop',
  'pop',
  'happy',
  'relax',
  'undertale',
  'jazz',
  'rock',
  'sleep',
  'calm',
  'hip_hop',
  'dance',
  'folk'
];
