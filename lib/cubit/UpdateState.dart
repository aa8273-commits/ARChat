import 'package:chatt/modols/updateModel.dart';

abstract class UpdateState {}

class UpdateInitial extends UpdateState {}

class UpdateLoading extends UpdateState {}

class UpdateSuccess extends UpdateState {}

class UpdateLoaded extends UpdateState {
  final List<UpdateModel> updates;

  UpdateLoaded(this.updates);
}

class UpdateFailure extends UpdateState {
  final String error;

  UpdateFailure(this.error);
}
