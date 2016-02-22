library songwoof.home;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:intl/intl.dart';

import 'package:songwoof/common/models/user_data.dart';
import 'package:songwoof/common/components/tag/tag.dart';

@Component(
    selector: 'swoof-home',
    templateUrl: 'home.html',
    directives: const [NgFor, NgClass, TagComponent])
class HomeComponent implements OnActivate {
  final Router _router;
  final UserData _userData;
  final _formatter = new DateFormat('yyyy-MM-dd');

  List<String> filterTags = [];
  Map<String, Object> fromFilter = {};

  List<Map<String, Object>> fromTags = [
    {'title': 'From Any Time', 'value': null},
    {
      'title': 'From A Year Ago',
      'value': new DateTime.now().subtract(new Duration(days: 365))
    },
    {
      'title': 'From Months Ago',
      'value': new DateTime.now().subtract(new Duration(days: 90))
    },
    {
      'title': 'From Last 30 Days',
      'value': new DateTime.now().subtract(new Duration(days: 30))
    },
  ];
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
    Map params = {'tags': filterTags.join(',')};

    if(fromFilter['value'] != null) {
      params['from'] = _formatter.format(fromFilter['value']);
    }

    _router.navigate(['Discover', params]);
  }

  bool isTagActive(String tag) {
    return filterTags.indexOf(tag) != -1;
  }

  bool isFromTagActive(Map<String, Object> tag) {
    return fromFilter['title'] == tag['title'];
  }

  void setFromFilter(Map<String, Object> tag) {
    if (fromFilter['title'] != tag['title']) {
      fromFilter = tag;
    } else {
      fromFilter = {};
    }
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
