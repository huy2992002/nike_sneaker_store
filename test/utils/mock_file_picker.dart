import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFilePicker extends Fake implements FilePicker {
  @override
  Future<FilePickerResult?> pickFiles(
      {String? dialogTitle,
      String? initialDirectory,
      FileType type = FileType.any,
      List<String>? allowedExtensions,
      Function(FilePickerStatus p1)? onFileLoading,
      bool allowCompression = true,
      int compressionQuality = 30,
      bool allowMultiple = false,
      bool withData = false,
      bool withReadStream = false,
      bool lockParentWindow = false,
      bool readSequential = false}) async {
    return FilePickerResult([
      PlatformFile(
        name: 'name',
        size: 12,
        path: 'abc',
      ),
    ]);
  }
}
