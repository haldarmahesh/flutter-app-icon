import 'dart:io';

import 'package:flutter_app_icon/android_platform_impl.dart';
import 'package:flutter_app_icon/assets/base_image.dart';
import 'package:flutter_app_icon/assets/font_asset.dart';
import 'package:image/image.dart';

class ImageUtils {
  AndroidPlatform androidPlatform;
  ImageUtils(this.androidPlatform);
  void generateImage(value, outputName) async {
    final bytes = ImageAssets.baseImage;
    final image = decodePng(bytes);
    final file = FontAsset.robotoFont;
    drawStringCentered(image, BitmapFont.fromZip(file), value ?? '');
    final iconName = '$outputName.png';
    File(iconName).writeAsBytesSync(encodePng(image));
  }

  void generateForAndroid(value) async {
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
    generateImage(value, outputName);
  }
}
