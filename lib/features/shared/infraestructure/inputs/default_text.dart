import 'package:formz/formz.dart';

enum DefaultTextError { empty, length }

class DefaultText extends FormzInput<String, DefaultTextError> {
  const DefaultText.pure() : super.pure('');

  const DefaultText.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DefaultTextError.empty) return 'El campo es requerido';
    if (displayError == DefaultTextError.length) return 'Mínimo 5 caracteres';

    return null;
  }

  @override
  DefaultTextError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DefaultTextError.empty;
    if (value.length < 5) return DefaultTextError.length;

    return null;
  }
}
