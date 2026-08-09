import 'package:chatt/Services/updates_service.dart';
import 'package:chatt/cubit/UpdateState.dart';
import 'package:chatt/modols/updateModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitial());

  final UpdateService _service = UpdateService();

  Future<String> uploadFile(File file, String type) async {
    return await _service.uploadFile(file, type);
  }

  Future<void> addUpdate({required UpdateModel update}) async {
    emit(UpdateLoading());

    try {
      await _service.addUpdate(update: update);

      getUpdates();
    } catch (e) {
      emit(UpdateFailure(e.toString()));
    }
  }

  void getUpdates() {
    emit(UpdateLoading());

    _service.getUpdates().listen(
      (updates) {
        emit(UpdateLoaded(updates));
      },

      onError: (e) {
        emit(UpdateFailure(e.toString()));
      },
    );
  }

  Future<void> seenUpdate({
    required String updateId,

    required String userId,
  }) async {
    try {
      await _service.addViewer(updateId: updateId, userId: userId);
    } catch (e) {
      emit(UpdateFailure(e.toString()));
    }
  }
}
