import 'dart:io';

import 'package:flutter_app_icon/android_platform_impl.dart';
import 'package:flutter_app_icon/assets/base_image.dart';
import 'package:flutter_app_icon/assets/font_asset.dart';
import 'package:image/image.dart';

class ImageUtils {
  AndroidPlatform androidPlatform;
  ImageUtils(this.androidPlatform);
  void generateIcon(String label, String outputName, String topLabel,
      String bottomLabel) async {
    final bytes = ImageAssets.baseImage;
    final image = decodePng(bytes);
    final file = FontAsset.robotoFont;
    drawStringCentered(image, BitmapFont.fromZip(file), label ?? '');

    final iconName = '$outputName.png';

    if (topLabel != null) {
      fillRect(image, 0, 0, image.width, 100, 0x5c5b5b70);
      var topLableYCordinate = (100 ~/ 2) -
          (arial_48.characters['U'.codeUnits[0]].height / 2).round();
      drawStringCentered(image, arial_48, topLabel, y: topLableYCordinate);
    }

    if (bottomLabel != null) {
      fillRect(
          image, 0, image.height - 100, image.width, image.height, 0x5c5b5b70);
      var bottomLableYCordinate = ((image.height - 100)) +
          50 -
          (arial_48.characters['U'.codeUnits[0]].height / 2).round();
      drawStringCentered(image, arial_48, bottomLabel,
          y: bottomLableYCordinate);
    }
    File(iconName).writeAsBytesSync(encodePng(image));
  }

  void generateForAndroid(label) async {
    String outputName;
    try {
      outputName = await androidPlatform.getIconNameFromXml();
    } on FileSystemException {
      stdout.writeln(
          'Couldn\'t find the manifest file, hence adding a default name');
    } catch (e) {
      stdout.writeln(e.toString());
      stdout.writeln(
          'Couldn\'t read the icon name from manifest file, hence adding a default name');
      outputName = 'icon';
    }
    generateIcon(label, outputName, '', '');
  }
}
