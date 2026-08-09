import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart' as picker;
import 'package:http/http.dart' as http;

class FileService {
  static Future<Map<String, String>?> pickAndUploadFile() async {
    final result = await picker.FilePicker.platform.pickFiles();

    if (result == null) return null;

    final file = File(result.files.single.path!);

    const cloudName = 'd1lhreuz';
    const uploadPreset = 'profile_upload';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/auto/upload',
    );

    final request = http.MultipartRequest('POST', url);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final data = json.decode(await response.stream.bytesToString());

      return {"url": data["secure_url"], "fileName": result.files.single.name};
    }

    return null;
  }
}
