import 'dart:io';

import 'package:flutter_app_icon/android_platform_impl.dart';
import 'package:flutter_app_icon/assets/base_image.dart';
import 'package:flutter_app_icon/assets/font_asset.dart';
import 'package:image/image.dart';

class ImageUtils {
  final _stripRectHeight = 100;
  final _stripBgColor = 0x5c5b5b70;
  final _labelFont = arial_48;
  AndroidPlatform androidPlatform;
  ImageUtils(this.androidPlatform);
  void generateIcon(String label, String outputName, String topLabel,
      String bottomLabel) async {
    final bytes = ImageAssets.baseImage;
    final image = decodePng(bytes);
    final file = FontAsset.robotoFont;
    drawStringCentered(image, BitmapFont.fromZip(file), label ?? '');

    final iconName = '$outputName.png';
    _drawTopLabel(topLabel, image);
    _drawBottomLabel(bottomLabel, image);
    File(iconName).writeAsBytesSync(encodePng(image));
  }

  void _drawTopLabel(String topLabel, Image image) {
    if (topLabel != null) {
      fillRect(image, 0, 0, image.width, _stripRectHeight, _stripBgColor);
      var topLableYCordinate =
          (_stripRectHeight ~/ 2) - (_getFontHeight() ~/ 2);
      drawStringCentered(image, _labelFont, topLabel, y: topLableYCordinate);
    }
  }

  int _getFontHeight() {
    return _labelFont.characters['U'.codeUnits[0]].height;
  }

  void _drawBottomLabel(String bottomLabel, Image image) {
    if (bottomLabel != null) {
      fillRect(image, 0, image.height - _stripRectHeight, image.width,
          image.height, _stripBgColor);
      var bottomLableYCordinate = (image.height - _stripRectHeight) +
          (_stripRectHeight ~/ 2) -
          (_getFontHeight() ~/ 2);
      drawStringCentered(image, _labelFont, bottomLabel,
          y: bottomLableYCordinate);
    }
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
