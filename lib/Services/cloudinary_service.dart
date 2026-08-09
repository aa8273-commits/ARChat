import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static Future<String?> uploadImage(File image) async {
    const cloudName = 'd1lhreuz';
    const uploadPreset = 'profile_upload';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', url);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      final jsonData = json.decode(data);

      return jsonData['secure_url'];
    }

    return null;
  }

  static Future<String?> uploadVideo(File videoFile) async {
    const cloudName = 'd1lhreuz';
    const uploadPreset = 'profile_upload';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/video/upload',
    );

    final request = http.MultipartRequest('POST', url);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(
      await http.MultipartFile.fromPath('file', videoFile.path),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final data = json.decode(await response.stream.bytesToString());
      return data["secure_url"];
    }

    return null;
  }
}
