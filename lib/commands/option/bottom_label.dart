import 'package:flutter_app_icon/common/option_abstract.dart';

class BottomLabelOption implements Option {
  @override
  String get abbr => 'b';

  @override
  String get help => 'The text will be added as the bottom label of the icon.';

  @override
  String get name => 'bottomLabel';
}
