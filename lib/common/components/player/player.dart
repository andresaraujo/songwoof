library songwoof.common.components.player;

import 'package:angular2/angular2.dart';
import 'package:songwoof/common/components/cover/cover.dart';
import 'package:songwoof/common/components/md_icon/md_icon.dart';
import 'package:songwoof/common/models/track.dart';
import 'package:songwoof/common/soundcloud/soundcloud_player.dart';

@Component(
    selector: 'swoof-player',
    templateUrl: 'player.html',
    directives: const [CoverComponent, MdIconComponent],
    providers: const [SoundCloudPlayer])
class SwoofPlayerComponent implements OnDestroy {
  final SoundCloudPlayer _scPlayer;
  Track _track;
  bool _firstSong = true;

  @Input() List<Track> trackList;

  @Output() EventEmitter<bool> onTogglePlay = new EventEmitter<bool>();
  @Output() EventEmitter<Track> onDismiss = new EventEmitter<Track>();
  @Output() EventEmitter<Track> onFavorite = new EventEmitter<Track>();
  @Output() EventEmitter<Track> onTrackChange = new EventEmitter<Track>();

  SwoofPlayerComponent(this._scPlayer) {
    _scPlayer.onEnded.listen(_onTrackEnded);
  }

  Track get track => _track;

  @Input()
  set track(Track newTrack) {
    if (trackList != null && _firstSong) {
      _playNext(newTrack);
      _firstSong = false;
    }
  }

  void dismiss() {
    onDismiss.add(track);
    _playNext();
  }

  void favorite() {
    onFavorite.add(track);
    //_playNext();
  }

  bool isPlaying() {
    return _scPlayer.isPlaying();
  }

  void togglePlay() {
    if (_scPlayer.isPlaying()) {
      _scPlayer.pause();
      onTogglePlay.add(true);
    } else {
      _scPlayer.play(track);
      onTogglePlay.add(false);
    }
  }

  Track _getNextTrack() {
    int nextIndex = trackList.indexOf(track) + 1;

    if (nextIndex < trackList.length) {
      return trackList.elementAt(nextIndex);
    }
    return null;
  }

  void _onTrackEnded(_) {
    _playNext();
  }

  void _playNext([track]) {
    var next = track ?? _getNextTrack();
    if (next != null) {
      _track = next;
      onTrackChange.add(next);
      _scPlayer.play(next);
    }
  }

  @override
  void ngOnDestroy() {
    _scPlayer.stop();
  }
}
