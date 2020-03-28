import 'package:flutter_app_icon/common/option_abstract.dart';

class LabelOption implements Option {
  @override
  String get abbr => 'l';

  @override
  String get name => 'label';

  @override
  String get help =>
      'This expects a String label and prints this label in the middle of the app icon. It add no text if no label is passed ';
}
