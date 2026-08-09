import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit() : super(const PrivacyState());

  Future<void> loadPrivacy() async {
    final prefs = await SharedPreferences.getInstance();

    emit(
      PrivacyState(
        lastSeen: prefs.getString("lastSeen") ?? "Everyone",
        profilePhoto: prefs.getString("profilePhoto") ?? "Everyone",
        addGroups: prefs.getString("addGroups") ?? "Everyone",
      ),
    );
  }

  Future<void> changeLastSeen(String value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("lastSeen", value);

    emit(state.copyWith(lastSeen: value));
  }

  Future<void> changeProfilePhoto(String value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("profilePhoto", value);

    emit(state.copyWith(profilePhoto: value));
  }

  Future<void> changeAddGroups(String value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("addGroups", value);

    emit(state.copyWith(addGroups: value));
  }
}
