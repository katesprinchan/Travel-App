import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:travel_application/core/domain/use_case_result/use_case_result.dart';
import 'package:travel_application/core/presentation/app_text_field/app_text_editing_controller.dart';
import 'package:travel_application/core/presentation/password_text_editing_controller.dart';
import 'package:travel_application/features/auth/domain/entity/auth_credentials.dart';
import 'package:travel_application/features/auth/domain/repository/auth_repository.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/features/settings/presentation/settings_modal_bs.dart';

class RecoveryViewModel {
  final AuthRepository _authRepository;
  final SettingsService _settingsService;

  RecoveryViewModel({
    required AuthRepository authRepository,
    required SettingsService settingService,
  })  : _authRepository = authRepository,
        _settingsService = settingService;

  late TabController tabController;

  final emailLoginTextCtrl = AppTextEditingController();
  final numberLoginTextCtrl1 = AppTextEditingController();
  final numberLoginTextCtrl2 = AppTextEditingController();
  final numberLoginTextCtrl3 = AppTextEditingController();
  final numberLoginTextCtrl4 = AppTextEditingController();
  final passwordRegisterTextCtrl = PassTextEditingController();
  final repeatPasswordRegisterTextCtrl = PassTextEditingController();

  final isLoginPossible = false.rv;

  final isSendPossible = false.rv;

  final isSaveNewPasswordPossible = false.rv;

  void init() {
    initListeners();
  }

  void dispose() {
    disposeListeners();
  }

  void _loginPossibilityListener() {
    if (emailLoginTextCtrl.text.isEmpty) {
      isLoginPossible(false);
      return;
    }
    isLoginPossible(true);
  }

  void _sendPossibilityListener() {
    if (numberLoginTextCtrl1.text.isEmpty ||
        numberLoginTextCtrl2.text.isEmpty ||
        numberLoginTextCtrl3.text.isEmpty ||
        numberLoginTextCtrl4.text.isEmpty) {
      isSendPossible(false);
      return;
    }
    isSendPossible(true);
  }

  void _isSaveNewPasswordPossible() {
    if (passwordRegisterTextCtrl.text.isEmpty ||
        repeatPasswordRegisterTextCtrl.text.isEmpty) {
      isSaveNewPasswordPossible(false);
      return;
    }
    isSaveNewPasswordPossible(true);
  }

  void _passwordVisibilityListener() {
    repeatPasswordRegisterTextCtrl
        .isTextHidden(passwordRegisterTextCtrl.isTextHidden());
  }

  void _repeatPasswordVisibilityListener() {
    passwordRegisterTextCtrl
        .isTextHidden(repeatPasswordRegisterTextCtrl.isTextHidden());
  }

  void initListeners() {
    emailLoginTextCtrl.addListener(_loginPossibilityListener);
    numberLoginTextCtrl1.addListener(_sendPossibilityListener);
    numberLoginTextCtrl2.addListener(_sendPossibilityListener);
    numberLoginTextCtrl3.addListener(_sendPossibilityListener);
    numberLoginTextCtrl4.addListener(_sendPossibilityListener);
    passwordRegisterTextCtrl.isTextHidden
        .addListener(_passwordVisibilityListener);
    repeatPasswordRegisterTextCtrl.isTextHidden
        .addListener(_repeatPasswordVisibilityListener);
    passwordRegisterTextCtrl.addListener(_isSaveNewPasswordPossible);
    repeatPasswordRegisterTextCtrl.addListener(_isSaveNewPasswordPossible);
  }

  void disposeListeners() {
    emailLoginTextCtrl.removeListener(_loginPossibilityListener);
    numberLoginTextCtrl1.removeListener(_sendPossibilityListener);
    numberLoginTextCtrl2.removeListener(_sendPossibilityListener);
    numberLoginTextCtrl3.removeListener(_sendPossibilityListener);
    numberLoginTextCtrl4.removeListener(_sendPossibilityListener);
    passwordRegisterTextCtrl.isTextHidden
        .removeListener(_passwordVisibilityListener);
    repeatPasswordRegisterTextCtrl.isTextHidden
        .removeListener(_repeatPasswordVisibilityListener);
    passwordRegisterTextCtrl.removeListener(_isSaveNewPasswordPossible);
    repeatPasswordRegisterTextCtrl.removeListener(_isSaveNewPasswordPossible);
  }

  Future<void> recoveryPassword() async {
    final result = await _authRepository.recoveryPassword(
      phone: emailLoginTextCtrl.text,
    );

    switch (result) {
      case GoodUseCaseResult<AuthCredentials>(:final data):
        log(data.jvtToken);
        break;
      case BadUseCaseResult<AuthCredentials>(:final errorList):
        for (final error in errorList) {
          log(error.code);
        }
        break;
    }
  }

  Future<void> signUp() async {
    final result = await _authRepository.signUp(
      password: passwordRegisterTextCtrl.text,
      repeatPassword: repeatPasswordRegisterTextCtrl.text,
    );

    switch (result) {
      case GoodUseCaseResult<AuthCredentials>(:final data):
        log(data.jvtToken);
        break;
      case BadUseCaseResult<AuthCredentials>(:final errorList):
        for (final error in errorList) {
          log(error.code);
        }
        break;
    }
  }

  Future<void> enterCode() async {
    final result = await _authRepository.enterCode(
      number1: numberLoginTextCtrl1.text,
      number2: numberLoginTextCtrl2.text,
      number3: numberLoginTextCtrl3.text,
      number4: numberLoginTextCtrl4.text,
    );

    switch (result) {
      case GoodUseCaseResult<AuthCredentials>(:final data):
        log(data.jvtToken);
        break;
      case BadUseCaseResult<AuthCredentials>(:final errorList):
        for (final error in errorList) {
          log(error.code);
        }
        break;
    }
  }

  void onSettingsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          SettingsModalBottomSheet(settingsService: _settingsService),
      showDragHandle: true,
    );
  }

  Future<void> sendVerificationCode() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailLoginTextCtrl.text.trim(),
      );
    } catch (e) {
      print('Error sending verification code: $e');
    }
  }
}
