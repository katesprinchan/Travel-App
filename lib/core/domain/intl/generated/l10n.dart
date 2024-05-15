// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Relax in Pridnestrovie`
  String get relaxInPridnestrovie {
    return Intl.message(
      'Relax in Pridnestrovie',
      name: 'relaxInPridnestrovie',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get repeatPassword {
    return Intl.message(
      'Repeat password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `I''m agreed with Privacy and Policy usage`
  String get imAgreedWithPrivacyAndPolicyUsage {
    return Intl.message(
      'I\'\'m agreed with Privacy and Policy usage',
      name: 'imAgreedWithPrivacyAndPolicyUsage',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message(
      'Dark theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Recovery password`
  String get recoveryPassword {
    return Intl.message(
      'Recovery password',
      name: 'recoveryPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email to which the password reset code will be sent`
  String get enterEmailToWhichPasswordResetCodeWillBeSent {
    return Intl.message(
      'Enter the email to which the password reset code will be sent',
      name: 'enterEmailToWhichPasswordResetCodeWillBeSent',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code`
  String get enterCode {
    return Intl.message(
      'Enter Code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to the number`
  String get enterCodeSentToTheNumber {
    return Intl.message(
      'Enter the code sent to the number',
      name: 'enterCodeSentToTheNumber',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Resend the code`
  String get resendCode {
    return Intl.message(
      'Resend the code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Save new password`
  String get saveNewPassword {
    return Intl.message(
      'Save new password',
      name: 'saveNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password and confirm it to complete the reset.`
  String get setNewPasswordConfirmItToCompleteReset {
    return Intl.message(
      'Set a new password and confirm it to complete the reset.',
      name: 'setNewPasswordConfirmItToCompleteReset',
      desc: '',
      args: [],
    );
  }

  /// `Search for advertisement`
  String get searchForAdvertisement {
    return Intl.message(
      'Search for advertisement',
      name: 'searchForAdvertisement',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `My`
  String get my {
    return Intl.message(
      'My',
      name: 'my',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get main {
    return Intl.message(
      'Main',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Tiraspol`
  String get tiraspol {
    return Intl.message(
      'Tiraspol',
      name: 'tiraspol',
      desc: '',
      args: [],
    );
  }

  /// `Rybnitsa`
  String get rybnitsa {
    return Intl.message(
      'Rybnitsa',
      name: 'rybnitsa',
      desc: '',
      args: [],
    );
  }

  /// `Bender`
  String get bender {
    return Intl.message(
      'Bender',
      name: 'bender',
      desc: '',
      args: [],
    );
  }

  /// `Dubossary`
  String get dubossary {
    return Intl.message(
      'Dubossary',
      name: 'dubossary',
      desc: '',
      args: [],
    );
  }

  /// `Grigoriopol`
  String get grigoriopol {
    return Intl.message(
      'Grigoriopol',
      name: 'grigoriopol',
      desc: '',
      args: [],
    );
  }

  /// `Kamenka`
  String get kamenka {
    return Intl.message(
      'Kamenka',
      name: 'kamenka',
      desc: '',
      args: [],
    );
  }

  /// `Slobodzeya`
  String get slobodzeya {
    return Intl.message(
      'Slobodzeya',
      name: 'slobodzeya',
      desc: '',
      args: [],
    );
  }

  /// `Dnestrovsk`
  String get dnestrovsk {
    return Intl.message(
      'Dnestrovsk',
      name: 'dnestrovsk',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filter {
    return Intl.message(
      'Filters',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Add city`
  String get addCity {
    return Intl.message(
      'Add city',
      name: 'addCity',
      desc: '',
      args: [],
    );
  }

  /// `Go Out`
  String get goOut {
    return Intl.message(
      'Go Out',
      name: 'goOut',
      desc: '',
      args: [],
    );
  }

  /// `About the application`
  String get aboutApplication {
    return Intl.message(
      'About the application',
      name: 'aboutApplication',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any advertisement yet`
  String get youDontHaveAnyAdvertisementYet {
    return Intl.message(
      'You don\'t have any advertisement yet',
      name: 'youDontHaveAnyAdvertisementYet',
      desc: '',
      args: [],
    );
  }

  /// `Don't miss the opportunity!\n Create and publish your ad right now to offer products or services to a wide audience.`
  String get dontMisstheOpportunity {
    return Intl.message(
      'Don\'t miss the opportunity!\n Create and publish your ad right now to offer products or services to a wide audience.',
      name: 'dontMisstheOpportunity',
      desc: '',
      args: [],
    );
  }

  /// `Add your favorite places`
  String get addFavorites {
    return Intl.message(
      'Add your favorite places',
      name: 'addFavorites',
      desc: '',
      args: [],
    );
  }

  /// `You can come back to them later`
  String get youCanComeBackToThemLater {
    return Intl.message(
      'You can come back to them later',
      name: 'youCanComeBackToThemLater',
      desc: '',
      args: [],
    );
  }

  /// `Favorites `
  String get favorite {
    return Intl.message(
      'Favorites ',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Editing profile`
  String get editingProfile {
    return Intl.message(
      'Editing profile',
      name: 'editingProfile',
      desc: '',
      args: [],
    );
  }

  /// `A confirmation email \n has been sent to your email.`
  String get emailVerified {
    return Intl.message(
      'A confirmation email \n has been sent to your email.',
      name: 'emailVerified',
      desc: '',
      args: [],
    );
  }

  /// `A password reset email \n has been sent to your email.`
  String get passwordReset {
    return Intl.message(
      'A password reset email \n has been sent to your email.',
      name: 'passwordReset',
      desc: '',
      args: [],
    );
  }

  /// `Resend email`
  String get resendEmail {
    return Intl.message(
      'Resend email',
      name: 'resendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Exchange rates`
  String get exchangeRates {
    return Intl.message(
      'Exchange rates',
      name: 'exchangeRates',
      desc: '',
      args: [],
    );
  }

  /// `The official currency of the PMR is the Pridnestrovian ruble.\n You can exchange Moldovan lei, Ukrainian hryvnia, Russian rubles, dollars and euros for it at all exchange offices in the republic. Other currencies can be exchanged at the central branch of the Transnistrian Republican Bank. It is impossible to exchange Romanian lei in Transnistria!\n Payment for services (restaurants, transport) in Transnistria is made only in PMR rubles.`
  String get officialCurrency {
    return Intl.message(
      'The official currency of the PMR is the Pridnestrovian ruble.\n You can exchange Moldovan lei, Ukrainian hryvnia, Russian rubles, dollars and euros for it at all exchange offices in the republic. Other currencies can be exchanged at the central branch of the Transnistrian Republican Bank. It is impossible to exchange Romanian lei in Transnistria!\n Payment for services (restaurants, transport) in Transnistria is made only in PMR rubles.',
      name: 'officialCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Authorization`
  String get authorization {
    return Intl.message(
      'Authorization',
      name: 'authorization',
      desc: '',
      args: [],
    );
  }

  /// `Passwords not matching`
  String get passwordsNotMatching {
    return Intl.message(
      'Passwords not matching',
      name: 'passwordsNotMatching',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get emailAlreadyInUse {
    return Intl.message(
      'Email already in use',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Email is incorrect`
  String get emailIsIncorrect {
    return Intl.message(
      'Email is incorrect',
      name: 'emailIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `The password is too light \nThe password must contain \nat least 8 characters \nnumbers and letters`
  String get passwordIsTooEasy {
    return Intl.message(
      'The password is too light \\nThe password must contain \\nat least 8 characters \\nnumbers and letters',
      name: 'passwordIsTooEasy',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password. Try again`
  String get incorrectEmailPassword {
    return Intl.message(
      'Incorrect email or password. Try again',
      name: 'incorrectEmailPassword',
      desc: '',
      args: [],
    );
  }

  /// `History of the region`
  String get historyOfRegion {
    return Intl.message(
      'History of the region',
      name: 'historyOfRegion',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Hotels`
  String get hotels {
    return Intl.message(
      'Hotels',
      name: 'hotels',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants`
  String get restaurants {
    return Intl.message(
      'Restaurants',
      name: 'restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Attractions`
  String get attractions {
    return Intl.message(
      'Attractions',
      name: 'attractions',
      desc: '',
      args: [],
    );
  }

  /// `Weather`
  String get weather {
    return Intl.message(
      'Weather',
      name: 'weather',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get webSite {
    return Intl.message(
      'Link',
      name: 'webSite',
      desc: '',
      args: [],
    );
  }

  /// `Registration date`
  String get registrationDate {
    return Intl.message(
      'Registration date',
      name: 'registrationDate',
      desc: '',
      args: [],
    );
  }

  /// `Registration date unknown`
  String get registrationDateUnknown {
    return Intl.message(
      'Registration date unknown',
      name: 'registrationDateUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Enter new name`
  String get enterNewName {
    return Intl.message(
      'Enter new name',
      name: 'enterNewName',
      desc: '',
      args: [],
    );
  }

  /// `Enter new email`
  String get enterNewEmail {
    return Intl.message(
      'Enter new email',
      name: 'enterNewEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment`
  String get addComment {
    return Intl.message(
      'Add a comment',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to `
  String get welcome {
    return Intl.message(
      'Welcome to ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// ` – your universal assistant for traveling to Pridnestrovie! Our application provides up-to-date information about the attractions of the cities of the PMR.`
  String get universalAssistant {
    return Intl.message(
      ' – your universal assistant for traveling to Pridnestrovie! Our application provides up-to-date information about the attractions of the cities of the PMR.',
      name: 'universalAssistant',
      desc: '',
      args: [],
    );
  }

  /// `Write a comment`
  String get writeComment {
    return Intl.message(
      'Write a comment',
      name: 'writeComment',
      desc: '',
      args: [],
    );
  }

  /// `Select image`
  String get selectImage {
    return Intl.message(
      'Select image',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
