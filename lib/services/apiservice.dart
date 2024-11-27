import 'package:http/http.dart' as http;
import '../models/registermodel.dart';

class ApiService {
  final String baseUrl = 'https://mad.thomaskreder.nl';

  Future<http.Response> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse(baseUrl + "/api/AM/register"),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: registerModel,
    );
    return response;
  }
}