import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;

void accessTokenGenerator() async {
  const String secret = 'secret_key';

  final jwt = JWT(
    {
      'id': 123,
    },
  );

  // Подпись токена
  final token = jwt.sign(SecretKey(secret));

  // Сохранение токена
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auto_token', token);
  print('Сгенерированный токен: $token');
}
