import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_development/services/auth/AuthService.dart';
import 'package:mobile_app_development/services/auth/MockStorage.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Given a token is set when getToken is called then return token', () async {

    AuthService authService = AuthService(MockStorage());
    authService.setDateTime(DateTime.fromMillisecondsSinceEpoch(1737391045000));

    String? initialToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1bml0dGVzdCIsImV4cCI6MTczNzM5MTA0NiwiYXV0aCI6IlJPTEVfVVNFUiIsImlhdCI6MTczNzMwNDY0Nn0.j_Qgk4_7KYwVj9LshRFnI7M59LOPFNPs2GhtSH0le_3gBcBf71lRG-aq5rq3TzOOFj3BUDLcQSat-jHFEIrzJg";

    await authService.saveToken(initialToken);

    String? storedToken = await authService.getToken();
    expect(storedToken, initialToken);
  });

  test('Given token is set when clearToken is called then token should be null', () async {
    AuthService authService = AuthService(MockStorage());

    await authService.saveToken('foo');
    await authService.clearToken();

    expect(await authService.getToken(), null);
  });

  test('Given token is passed when decodeToken is called then return map of parts', () async {
    AuthService authService = AuthService(MockStorage());

    String token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1bml0dGVzdCIsImV4cCI6MTczNzM5MTA0NiwiYXV0aCI6IlJPTEVfVVNFUiIsImlhdCI6MTczNzMwNDY0Nn0.j_Qgk4_7KYwVj9LshRFnI7M59LOPFNPs2GhtSH0le_3gBcBf71lRG-aq5rq3TzOOFj3BUDLcQSat-jHFEIrzJg";

    Map<String, dynamic> expectedDecodedToken = {'sub': 'unittest', 'exp': 1737391046, 'auth': 'ROLE_USER', 'iat': 1737304646};
    Map<String, dynamic>? actualDecodedToken = authService.decodeToken(token);
    expect(expectedDecodedToken, actualDecodedToken);
  });

  test('Given token is malformed when decodeToken is called then return null', () async {
    AuthService authService = AuthService(MockStorage());

    String token = "malformed";

    expect(authService.decodeToken(token), null);
  });

  test('Given token is not yet expired when isTokenExpired is called then return false', () {
    AuthService authService = AuthService(MockStorage());

    //Making sure that the token expiry date is tested against a fixed moment in time and not right now
    //Fixed date is 2025-01-20 17:37:25.000
    authService.setDateTime(DateTime.fromMillisecondsSinceEpoch(1737391045000));

    String token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1bml0dGVzdCIsImV4cCI6MTczNzM5MTA0NiwiYXV0aCI6IlJPTEVfVVNFUiIsImlhdCI6MTczNzMwNDY0Nn0.j_Qgk4_7KYwVj9LshRFnI7M59LOPFNPs2GhtSH0le_3gBcBf71lRG-aq5rq3TzOOFj3BUDLcQSat-jHFEIrzJg";
    expect(authService.isTokenExpired(token), false);
  });

  test('Given token is  expired when isTokenExpired is called then return true', () {
    AuthService authService = AuthService(MockStorage());

    //Making sure that the token expiry date is tested against a fixed moment in time and not right now
    //Fixed date is 2025-01-20 17:37:26.001
    authService.setDateTime(DateTime.fromMillisecondsSinceEpoch(1737391046001));

    //Token expiry is 2025-01-20 17:37:26.000
    String token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1bml0dGVzdCIsImV4cCI6MTczNzM5MTA0NiwiYXV0aCI6IlJPTEVfVVNFUiIsImlhdCI6MTczNzMwNDY0Nn0.j_Qgk4_7KYwVj9LshRFnI7M59LOPFNPs2GhtSH0le_3gBcBf71lRG-aq5rq3TzOOFj3BUDLcQSat-jHFEIrzJg";

    expect(authService.isTokenExpired(token), true);
  });
}