// import 'package:flutter_app_icon/commands/option/help_option.dart';
import 'package:flutter_app_icon/commands/option/label_option.dart';
import 'package:flutter_app_icon/commands/option/output_option.dart';
import 'package:flutter_app_icon/commands/option/top_label_option.dart';
import 'package:flutter_app_icon/common/command_abstract.dart';
import 'package:flutter_app_icon/common/option_abstract.dart';

class GenerateCommand extends Command {
  final List<Option> _optionLists = [
    LabelOption(),
    OutputOption(),
    TopLableOption()
  ];

  @override
  String get name => 'generate';

  @override
  List<Option> get optionList => _optionLists;
}
