mixin ValidateFormFields {
  String? isValidEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || !emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  String? isValidPassword(String? value) {
    // final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (value == null) {
      // || !passwordRegex.hasMatch(value)) {
      return 'Senha inválida';
    }
    return null;
  }

  String? isValidField(String? value) {
    if (value == null) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? isValidName(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length < 3 ||
        value.length > 100) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
