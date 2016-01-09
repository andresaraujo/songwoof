library songwoof.common.components.tag;

import 'package:angular2/angular2.dart';

@Component(
    selector: 'swoof-tag', templateUrl: 'tag.html', directives: const [NgClass])
class TagComponent {
  @Input() bool active = false;
  @Input() String title;
}
