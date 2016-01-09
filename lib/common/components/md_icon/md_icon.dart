import 'package:angular2/angular2.dart';

@Component(
    selector: 'md-icon',
    templateUrl: 'md_icon.html')
class MdIconComponent {
  @Output() EventEmitter onClick = new EventEmitter();

  void click(event) {
    onClick.add(event);
  }
}
