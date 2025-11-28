class LoginState {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitted;

  LoginState({
    required this.email,
    required this.password,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitted,
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitted: true,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitted,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
