import 'package:travel_application/core/data/model/rest_api_error_model.dart';
import 'package:travel_application/core/data/remote_response.dart';
import 'package:travel_application/features/auth/data/model/auth_credentials.dart';
import 'package:travel_application/features/auth/data/source/auth_data.dart';

class AuthMockedDataSource implements AuthDataSource {
  @override
  Future<RemoteResponse<AuthCredentialsModel>> signIn(
      {required String phone, required String password}) async {
    await Future.delayed(const Duration(seconds: 5));
    if (phone.length == 8 && password.length == 5) {
      return DataRemoteResponse(
        data: AuthCredentialsModel(
            jvtToken: 'Количество цифр в номере равно 8, а в пароле 5'),
      );
    } else {
      return ErrorRemoteResponse(
        title: 'auth failed',
        detail: 'wrong arguments',
        errorList: [
          RestApiValidationErrorModel(
            fieldName: 'password',
            errorList: [
              (code: ' Не соответствие условию ', params: null),
            ],
          ),
        ],
      );
    }
  }

  @override
  Future<RemoteResponse<AuthCredentialsModel>> signUp(
      {required String password, required String repeatPassword}) async {
    await Future.delayed(const Duration(seconds: 5));
    if (password == repeatPassword) {
      return DataRemoteResponse(
        data: AuthCredentialsModel(
            jvtToken: 'Пароль и повторите пароль совпадают'),
      );
    } else {
      return ErrorRemoteResponse(
        title: 'auth failed',
        detail: 'wrong arguments',
        errorList: [
          RestApiValidationErrorModel(
            fieldName: 'password',
            errorList: [
              (code: 'Пароли не совпадают', params: null),
            ],
          ),
        ],
      );
    }
  }

  @override
  Future<RemoteResponse<AuthCredentialsModel>> recoveryPassword({
    required String phone,
  }) async {
    await Future.delayed(const Duration(seconds: 5));
    if (phone.length == 8) {
      return DataRemoteResponse(
        data: AuthCredentialsModel(
            jvtToken: 'Всё отлично! Количество цифр в номере равно 8'),
      );
    } else {
      return ErrorRemoteResponse(
        title: 'auth failed',
        detail: 'wrong arguments',
        errorList: [
          RestApiValidationErrorModel(
            fieldName: 'phone',
            errorList: [
              (code: 'Номер недостаточной длины', params: null),
            ],
          ),
        ],
      );
    }
  }

  @override
  Future<RemoteResponse<AuthCredentialsModel>> enterCode({
    required String number1,
    required String number2,
    required String number3,
    required String number4,
  }) async {
    await Future.delayed(const Duration(seconds: 5));
    if (number1.length == 1 &&
        number2.length == 1 &&
        number3.length == 1 &&
        number4.length == 1) {
      return DataRemoteResponse(
        data: AuthCredentialsModel(jvtToken: 'В каждом textfield по 1 цифре'),
      );
    } else {
      return ErrorRemoteResponse(
        title: 'auth failed',
        detail: 'wrong arguments',
        errorList: [
          RestApiValidationErrorModel(
            fieldName: 'phone',
            errorList: [
              (code: 'В textfield больше 1 цифры', params: null),
            ],
          ),
        ],
      );
    }
  }
}
