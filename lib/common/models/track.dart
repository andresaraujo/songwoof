library somgwoof.models.track;

class Track {
  int id;
  String artworkUrl;
  String title;
  String username;
  String streamUrl;
  String permalinkUrl;
  String firebaseKey;

  Track();

  Track.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'] ?? '';
    username = map['user'] != null ? map['user']['username'] : map['username'];
    artworkUrl = map['artwork_url'] ?? '/doge_300x300.jpeg';
    streamUrl = map['stream_url'];
    permalinkUrl = map['permalink_url'];
    firebaseKey = map['fb_key'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': '$id',
      'title': '$title',
      'username': '$username',
      'artworkUrl': '$artworkUrl',
      'streamUrl': '$streamUrl',
      'permalinkUrl': '$permalinkUrl',
      'firebaseKey': '$firebaseKey'
    };
  }

  toString() => toMap().toString();
  bool operator ==(o) => o is Track && id == o.id;
}
