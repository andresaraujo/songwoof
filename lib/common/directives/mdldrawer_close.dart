library songwoof.common.components.mdldrawer_close;

import 'package:angular2/angular2.dart';
import 'dart:html';

@Directive(
  selector: '[mdldrawer-close]'
)
class MdlDrawerClose {
  MdlDrawerClose(){}

  @HostListener('click')
  closeDrawer() {
    querySelector('.mdl-layout__obfuscator').classes.remove('is-visible');
    querySelector('.mdl-layout__drawer').classes.remove('is-visible');
  }
}