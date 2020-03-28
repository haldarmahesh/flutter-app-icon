import 'package:flutter_app_icon/common/option_abstract.dart';

abstract class Command {
  String get name;
  List<Option> get optionList;
  Option getOption<T>() {
    Option result;

    optionList.forEach((option) {
      if (option is T) {
        result = option;
      }
    });
    if (result == null) {
      throw Exception('The option of type ${T} is not defined in list');
    }
    return result;
  }
}
