import 'package:chatt/modols/updateModel.dart';

class UpdateGroupModel {
  final String userId;
  final String username;
  final String image;
  final List<UpdateModel> updates;

  UpdateGroupModel({
    required this.userId,

    required this.username,

    required this.image,

    required this.updates,
  });
}
