import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_app_icon/assets/base_image.dart';
import 'package:flutter_app_icon/assets/font_asset.dart';
import 'package:image/image.dart';

int calculate() {
  return 6 * 7;
}

ArgResults argResults;
const lineNumber = 'line-number';
const label = 'lable';
void main(List<String> arguments) {
  // sample(arguments);
  final parser = ArgParser()
    ..addCommand('generate',
        ArgParser()..addOption('label', abbr: 'l', callback: generateImage));
  argResults = parser.parse(arguments);

  stdout.writeln('>> ${argResults.rest}');
}

void generateImage(value) async {
  final bytes = ImageAssets.baseImage;
  final image = decodePng(bytes);
  // fill(image, getColor(0, 0, 255));
  final file = FontAsset.robotoFont;
  drawStringCentered(image, BitmapFont.fromZip(file), value ?? '');

  File('some.png').writeAsBytesSync(encodePng(image));
}

void sample(List<String> arguments) {
  exitCode = 0;

  final parser = ArgParser()..addFlag(lineNumber, negatable: false, abbr: 'n');

  argResults = parser.parse(arguments);
  final paths = argResults.rest;
  stdout.writeln('>> $paths');
  dcat(paths, argResults[lineNumber] as bool);
}

Future dcat(List<String> paths, bool showLineNumbers) async {
  if (paths.isEmpty) {
    await stdin.pipe(stdout);
  } else {
    for (var path in paths) {
      var lineNumber = 1;
      final lines = utf8.decoder
          .bind(File(path).openRead())
          .transform(const LineSplitter());

      try {
        await for (var line in lines) {
          if (showLineNumbers) {
            stdout.write('${lineNumber++}');
          }

          stdout.writeln(line);
        }
      } catch (_) {
        await _handleError(path);
      }
    }
  }
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
