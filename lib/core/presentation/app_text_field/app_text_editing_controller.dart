import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

class AppTextEditingController extends TextEditingController {
  final Rv<String?> errorText = Rv(null);

  AppTextEditingController({
    String? text,
  }) : super(text: text);

  void validateEmail() {
    final String value = text;
    if (value.isEmpty) {
      errorText.value = 'Email не может быть пустым';
    } else if (!EmailValidator.validate(value)) {
      errorText.value = 'Введите корректный email';
    } else {
      errorText.value = null;
    }
  }
}
