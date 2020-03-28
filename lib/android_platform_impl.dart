import 'dart:io';

class AndroidPlatform {
  final androidManifestFilePath =
      '/Users/mahesh/Documts/personal/flutter_clock/digital_clock/android/app/src/main/AndroidManifest.xml';
  RegExp iconNameRegExp = RegExp(
    r'''(?<=android:icon="@mipmap\/)[^"]*(\\"[^"]*)*(?=">)''',
    caseSensitive: false,
    multiLine: false,
  );
  Future<String> getIconNameFromXml() async {
    final manifestFile = File(androidManifestFilePath);
    final manifestLines = await manifestFile.readAsLines();
    for (var index = 0; index < manifestLines.length; index++) {
      var line = manifestLines[index];
      if (line.contains('android:icon')) {
        return iconNameRegExp.stringMatch(line).toString();
      }
    }

    throw Exception('Couldn\'t read icon name from manifest file');
  }
}
