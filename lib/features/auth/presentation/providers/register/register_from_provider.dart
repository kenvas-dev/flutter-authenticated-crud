import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infraestructure/inputs/inputs.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final Password passwordConfirm;
  final DefaultText fullName;

  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.passwordConfirm = const Password.pure(),
      this.fullName = const DefaultText.pure()});

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    Password? passwordConfirm,
    DefaultText? fullName,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        fullName: fullName ?? this.fullName,
      );

  @override
  String toString() {
    return '''
    RegisterFormState
      isPosting = $isPosting,
      isFormPosted = $isFormPosted,
      isValid = $isValid,
      email = $email,
      password = $password,
      passwordConfirm = $passwordConfirm,
      fullName = $fullName,
    ''';
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate(
            [newEmail, state.password, state.passwordConfirm, state.fullName]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate(
            [newPassword, state.email, state.passwordConfirm, state.fullName]));
  }

  onPasswordConfirmChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        passwordConfirm: newPassword,
        isValid: Formz.validate(
            [newPassword, state.email, state.password, state.fullName]));
  }

  onFullNameChange(String value) {
    final newFullName = DefaultText.dirty(value);
    state = state.copyWith(
        fullName: newFullName,
        isValid: Formz.validate([
          newFullName,
          state.email,
          state.password,
          state.passwordConfirm,
          state.fullName
        ]));
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    await registerUserCallback(
        state.email.value, state.password.value, state.fullName.value);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final passwordConfirm = Password.dirty(state.passwordConfirm.value);
    final fullName = DefaultText.dirty(state.fullName.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        fullName: fullName,
        isValid: Formz.validate([email, password, passwordConfirm, fullName]));

    if (passwordConfirm != password) {
      state = state.copyWith(isValid: false);
    }
  }
}

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});
