library songwoof.common.components.cover;

import 'package:angular2/angular2.dart';

@Component(
    selector: 'cover', templateUrl: 'cover.html', directives: const [NgClass])
class CoverComponent {
  String _coverUrl;
  @Input() bool rotate = true;

  String get coverUrl => _coverUrl;

  @Input('coverUrl')
  void set coverUrl(coverUrl) => _coverUrl = coverUrl ?? 'doge_300x300.jpeg';
}
