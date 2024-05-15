import 'package:travel_application/core/domain/use_case_result/use_case_result.dart';
import 'package:travel_application/features/auth/domain/entity/auth_credentials.dart';
import 'package:travel_application/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepo;

  SignInUseCase(this._authRepo);

  Future<UseCaseResult<AuthCredentials>> call({
    required final String phone,
    required final String password,
  }) {
    return _authRepo.signIn(phone: phone, password: password);
  }
}
