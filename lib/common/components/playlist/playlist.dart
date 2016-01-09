library songwoof.common.components.playlist;

import 'package:angular2/angular2.dart';
import 'package:songwoof/common/models/track.dart';

@Component(
    selector: 'swoof-playlist',
    templateUrl: 'playlist.html',
    directives: const [NgFor, NgIf])
class PlaylistComponent implements AfterContentChecked {
  @Input() List<Track> tracks;
  @Input() Track current;
  @Input() bool hidePrevious = false;
  @Input() int tracksToShow = -1;

  @Output() EventEmitter onTrackSelected = new EventEmitter();

  bool isHidden(int index) {
    return (tracksToShow > -1 && index >= tracksToShow);
  }

  void trackSelected(Track track) {
    onTrackSelected.add(track);
  }

  @override
  void ngAfterContentChecked() {
    if (tracks != null && hidePrevious) {
      tracks = tracks.sublist(tracks.indexOf(current) + 1);
    }
  }
}
