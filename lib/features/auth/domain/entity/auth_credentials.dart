import 'package:travel_application/features/auth/data/model/auth_credentials.dart';

class AuthCredentials {
  final String jvtToken;

  const AuthCredentials(this.jvtToken);

  factory AuthCredentials.fromModel(AuthCredentialsModel model) =>
      AuthCredentials(model.jvtToken);
}
