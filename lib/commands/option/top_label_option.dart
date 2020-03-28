import 'package:flutter_app_icon/common/option_abstract.dart';

class TopLableOption implements Option {
  @override
  String get abbr => 't';

  @override
  String get help =>
      'The text passed in this will be added as the top label of the icon.';

  @override
  String get name => 'topLabel';
}
