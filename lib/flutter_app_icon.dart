import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_app_icon/android_platform_impl.dart';
import 'package:flutter_app_icon/commands/generate_command.dart';
import 'package:flutter_app_icon/commands/option/label_option.dart';
import 'package:flutter_app_icon/commands/option/output_option.dart';
import 'package:flutter_app_icon/image_utils.dart';

ArgResults argResults;
final android = AndroidPlatform();
final imageUtils = ImageUtils(android);
final generateCommand = GenerateCommand();
final labelOption = generateCommand.getOption<LabelOption>();
final outputOption = generateCommand.getOption<OutputOption>();
void main(List<String> arguments) {
  final generateOptionParser = ArgParser()
    ..addOption(
      labelOption.name,
      abbr: labelOption.abbr,
    )
    ..addOption(
      outputOption.name,
      abbr: outputOption.abbr,
    )
    ..addFlag('help',
        abbr: 'h', negatable: false, help: 'Print this usage information.');
  final commandParser = ArgParser()
    ..addCommand(
      generateCommand.name,
      generateOptionParser,
    );
  argResults = commandParser.parse(arguments);
  final generateOptionResult = generateOptionParser.parse(arguments);
  if (generateOptionResult['help'] as bool) {
    print(generateOptionParser.usage);
    return;
  }

  generateIcon(generateOptionResult);
}

void generateIcon(ArgResults parsedResult) {
  String label = parsedResult[labelOption.name];
  String outputFileName = parsedResult[outputOption.name] ?? 'icon';

  imageUtils.generateIcon(label, outputFileName);
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
