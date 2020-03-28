import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_app_icon/android_platform_impl.dart';
import 'package:flutter_app_icon/commands/generate_command.dart';
import 'package:flutter_app_icon/commands/option/bottom_label.dart';
import 'package:flutter_app_icon/commands/option/label_option.dart';
import 'package:flutter_app_icon/commands/option/output_option.dart';
import 'package:flutter_app_icon/commands/option/top_label_option.dart';
import 'package:flutter_app_icon/image_utils.dart';

ArgResults argResults;
final android = AndroidPlatform();
final imageUtils = ImageUtils(android);
final generateCommand = GenerateCommand();
final labelOption = generateCommand.getOption<LabelOption>();
final outputOption = generateCommand.getOption<OutputOption>();
final topLabelOption = generateCommand.getOption<TopLableOption>();
final bottomLabelOption = generateCommand.getOption<BottomLabelOption>();

void main(List<String> arguments) {
  final generateOptionParser = _getGenerateOptionParser();
  final commandParser = ArgParser()
    ..addCommand(
      generateCommand.name,
      generateOptionParser,
    )
    ..addFlag('help', abbr: 'h', help: 'Print 123');
  argResults = commandParser.parse(arguments);
  if (argResults['help'] as bool) {
    _printHelpForRootCommand(commandParser, generateOptionParser);
    return;
  }
  final generateOptionResult = generateOptionParser.parse(arguments);
  if (generateOptionResult['help'] as bool) {
    print(generateOptionParser.usage);
    return;
  }
  // the user is not seeking help and respond to the command

  generateIcon(generateOptionResult);
}

void _printHelpForRootCommand(
    ArgParser commandParser, ArgParser generateOptionParser) {
  print('>>>>>>> HELPING');
  print('''
Usage: convert_stack_traces <command> [options] ...
Commands:
${commandParser.commands.keys.join("\n")}
Options shared by all commands:
${commandParser.usage}''');
  print(commandParser.usage);
}

ArgParser _getGenerateOptionParser() {
  return ArgParser()
    ..addOption(labelOption.name,
        abbr: labelOption.abbr, help: labelOption.help)
    ..addOption(outputOption.name,
        abbr: outputOption.abbr, help: outputOption.help, valueHelp: '12312')
    ..addOption(topLabelOption.name,
        abbr: topLabelOption.abbr, help: topLabelOption.help)
    ..addOption(bottomLabelOption.name,
        abbr: bottomLabelOption.abbr, help: bottomLabelOption.help)
    ..addFlag('help',
        abbr: 'h', negatable: false, help: 'Print this usage information.');
}

void generateIcon(ArgResults parsedResult) {
  String label = parsedResult[labelOption.name];
  String outputFileName = parsedResult[outputOption.name] ?? 'icon';

  String topLabel = parsedResult[topLabelOption.name];
  String bottomLabel = parsedResult[bottomLabelOption.name];
  imageUtils.generateIcon(label, outputFileName, topLabel, bottomLabel);
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
