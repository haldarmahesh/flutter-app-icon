import 'package:flutter_app_icon/common/option_abstract.dart';

class OutputOption implements Option {
  @override
  String get abbr => 'o';

  @override
  String get name => 'ouput';

  @override
  String get help =>
      'This expects one string, the filename of the icon is this. If no output fileenam is passeed the default filename is icon. This generates .png format. So you need not pass format';
}
