import 'package:flutter_app_icon/common/option_abstract.dart';

class HelpOption implements Option {
  @override
  String get abbr => 'h';

  @override
  String get name => 'help';

  @override
  String get help =>
      'The flag to show the help text and details of the options available.';
}
