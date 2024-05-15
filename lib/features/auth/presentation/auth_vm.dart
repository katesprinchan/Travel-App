import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/app_text_field/app_text_editing_controller.dart';
import 'package:travel_application/core/presentation/password_text_editing_controller.dart';
import 'package:travel_application/features/auth/data/source/user_model.dart';
import 'package:travel_application/features/auth/domain/repository/user_repository.dart';
import 'package:travel_application/features/auth/presentation/snack_bar.dart';
import 'package:travel_application/features/settings/domain/service/settings_service.dart';
import 'package:travel_application/features/settings/presentation/settings_modal_bs.dart';
import 'package:travel_application/routing.dart';

class AuthViewModel {
  final SettingsService _settingsService;

  AuthViewModel({
    required SettingsService settingService,
  }) : _settingsService = settingService;

  late TabController tabController;

  final emailLoginTextCtrl = AppTextEditingController();
  final passwordLoginTextCtrl = PassTextEditingController();
  final nameRegisterTextCtrl = AppTextEditingController();
  final emailRegisterTextCtrl = AppTextEditingController();
  final passwordRegisterTextCtrl = PassTextEditingController();
  final repeatPasswordRegisterTextCtrl = PassTextEditingController();
  Timer? timer;

  bool isEmailVerified = false;

  final canResendEmail = false;

  final isUserAgreedWithPnPUsage = false.rv;

  final isButtonDisabled = false.rv;

  final isLoginPossible = false.rv;

  final isRegisterPossible = false.rv;

  void init({
    required final TabController tabController,
  }) {
    this.tabController = tabController;
    initListeners();
  }

  void dispose() {
    disposeListeners();
    timer?.cancel();
  }

  void _loginPossibilityListener() {
    if (emailLoginTextCtrl.text.isEmpty || passwordLoginTextCtrl.text.isEmpty) {
      isLoginPossible(false);
      return;
    }

    isLoginPossible(true);
  }

  void _registerPossibilityChanger() {
    if (!isUserAgreedWithPnPUsage()) {
      isRegisterPossible(false);
      return;
    }

    if (nameRegisterTextCtrl.text.isEmpty ||
        emailRegisterTextCtrl.text.isEmpty ||
        passwordRegisterTextCtrl.text.isEmpty ||
        repeatPasswordRegisterTextCtrl.text.isEmpty) {
      isRegisterPossible(false);
      return;
    }

    isRegisterPossible(true);
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
    isUserAgreedWithPnPUsage.addListener(_registerPossibilityChanger);
    emailLoginTextCtrl.addListener(_loginPossibilityListener);
    passwordLoginTextCtrl.addListener(_loginPossibilityListener);
    passwordRegisterTextCtrl.isTextHidden
        .addListener(_passwordVisibilityListener);
    repeatPasswordRegisterTextCtrl.isTextHidden
        .addListener(_repeatPasswordVisibilityListener);
    nameRegisterTextCtrl.addListener(_registerPossibilityChanger);
    emailRegisterTextCtrl.addListener(_registerPossibilityChanger);
    passwordRegisterTextCtrl.addListener(_registerPossibilityChanger);
    repeatPasswordRegisterTextCtrl.addListener(_registerPossibilityChanger);
  }

  void disposeListeners() {
    isUserAgreedWithPnPUsage.removeListener(_registerPossibilityChanger);
    emailLoginTextCtrl.removeListener(_loginPossibilityListener);
    passwordLoginTextCtrl.removeListener(_loginPossibilityListener);
    passwordRegisterTextCtrl.isTextHidden
        .removeListener(_passwordVisibilityListener);
    repeatPasswordRegisterTextCtrl.isTextHidden
        .removeListener(_repeatPasswordVisibilityListener);
    nameRegisterTextCtrl.removeListener(_registerPossibilityChanger);
    emailRegisterTextCtrl.removeListener(_registerPossibilityChanger);
    passwordRegisterTextCtrl.removeListener(_registerPossibilityChanger);
    repeatPasswordRegisterTextCtrl.removeListener(_registerPossibilityChanger);
  }

  void onCheckBoxChecked(bool? value) =>
      isUserAgreedWithPnPUsage(value ?? false);

  Future<void> signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailLoginTextCtrl.text.trim(),
        password: passwordLoginTextCtrl.text.trim(),
      )
          .then((userCredential) {
        context.go(AppRouteList.citiesListPage);
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          S.of(context).incorrectEmailPassword,
          true,
        );
      } else if (e.code == 'invalid-credential') {
        SnackBarService.showSnackBar(
          context,
          S.of(context).incorrectEmailPassword,
          true,
        );
      } else {
        SnackBarService.showSnackBar(
          context,
          S.of(context).unknownError,
          true,
        );
      }
    }
  }

  Future<void> signUp(BuildContext context) async {
    final UserRepository userRepository = UserRepository(context);
    if (passwordRegisterTextCtrl.text != repeatPasswordRegisterTextCtrl.text) {
      SnackBarService.showSnackBar(
        context,
        S.of(context).passwordsNotMatching,
        true,
      );
      return;
    }
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailRegisterTextCtrl.text.trim(),
        password: passwordRegisterTextCtrl.text.trim(),
      );
      final uid = userCredential.user!.uid;
      UserModel userdb = UserModel(
        fullName: nameRegisterTextCtrl.text.trim(),
        email: emailRegisterTextCtrl.text.trim(),
      );
      userRepository.createUser(uid, userdb);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        context.go(AppRouteList.emailAddressVerificationPage);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          S.of(context).emailAlreadyInUse,
          true,
        );
      } else if (e.code == 'invalid-email') {
        SnackBarService.showSnackBar(
          context,
          S.of(context).emailIsIncorrect,
          true,
        );
      } else if (e.code == 'weak-password') {
        SnackBarService.showSnackBar(
          context,
          S.of(context).passwordIsTooEasy,
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          S.of(context).unknownError,
          true,
        );
      }
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

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      print(isEmailVerified);
      if (isEmailVerified) timer?.cancel();
    } catch (e) {
      print(e);
    }
  }
}
