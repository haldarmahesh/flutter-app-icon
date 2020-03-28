import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_app_icon/android_platform_impl.dart';
import 'package:flutter_app_icon/commands/generate_command.dart';
import 'package:flutter_app_icon/commands/option/label_option.dart';
import 'package:flutter_app_icon/image_utils.dart';

ArgResults argResults;
void main(List<String> arguments) {
  final android = AndroidPlatform();
  final imageUtils = ImageUtils(android);
  final generateCommand = GenerateCommand();
  final labelOption = generateCommand.getOption<LabelOption>();

  final parser = ArgParser()
    ..addCommand(
      generateCommand.name,
      ArgParser()
        ..addOption(labelOption.name,
            abbr: labelOption.abbr,
            callback: imageUtils.generateIconWithDefaultName),
    );
  argResults = parser.parse(arguments);

  stdout.writeln('>> ${argResults.rest}');
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
