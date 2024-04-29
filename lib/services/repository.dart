import 'dart:convert';
import 'package:http/http.dart' as http;



Future<List<dynamic>> fetchdata() async {
  try {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['items'];
    }
    return [];
  } catch (e) {
    throw Exception(e.toString());
  }
}

submitData(String title, String description) async {
  final body = {"title": title, "description": description};
  const url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  try {
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      print('Success');
      return 'success';
    }
  } catch (e) {
    throw Exception(e);
  }
}

