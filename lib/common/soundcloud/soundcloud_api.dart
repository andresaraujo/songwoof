library songwoof.common.services.soundcloud.soundcloud_api;

import 'dart:async';
import 'dart:convert' show JSON;

import 'package:angular2/angular2.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' show Response;

import 'package:songwoof/common/models/track.dart';
import 'package:songwoof/common/soundcloud/soundcloud_config.dart';

@Injectable()
class SoundCloudApi {
  final SoundCloudConfig _config;
  final BrowserClient _http;

  SoundCloudApi(this._config, this._http);

  Future<List<Track>> tracks({String tags, int limit: 100}) {
    var params = {'client_id': _config.CLIENT_ID};

    params['limit'] = '$limit';
    params['tags'] = tags ?? 'ambient';
    params['license'] = 'cc-by';

    Uri uri = new Uri(
        path: '${_config.SOUND_CLOUD_BASE}/tracks', queryParameters: params);

    return _http.get(uri.toString()).then(_toJson).then(_toModels);
  }
}

List<Map<String, String>> _toJson(Response response) {
  return JSON.decode(response.body);
}

List<Track> _toModels(List<Map<String, dynamic>> tracks) {
  var list = tracks.map((t) => new Track.fromMap(t)).toList();
  list.shuffle();
  return list;
}
