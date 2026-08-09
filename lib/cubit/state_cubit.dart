class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String name;
  final String email;

  AuthSuccess({required this.name, required this.email});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class ChangePasswordVisibilityState extends AuthState {}
