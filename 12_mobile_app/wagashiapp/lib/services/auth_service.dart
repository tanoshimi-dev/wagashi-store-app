import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // エミュレーターから（ローカルPC内の）dockerコンテナへのアドレスは10.0.2.2となる
  //final String baseUrl = 'http://10.0.2.2:11131/api';

  // 物理デバイスから（ローカルPC内の）dockerコンテナへのアドレスは？？
  // PCでifconfigで表示されたeen0のinetアドレス。（PC ゲートウェイ 192.168.0.1）
  // スマホのゲートウェイアドレス（スマホゲートウェイ 192.168.0.1）
  // 同じネットワークにないとダメ
  final String baseUrl =
      'http://192.168.0.154:11131/api'; // Replace with your local machine's IP address

  //final String baseUrl = 'http://localhost:11131/api';
  //final String baseUrl = 'http://172.20.0.5:11131/api';

  Future<bool> hello() async {
    print('AuthService hello button pressed　！！');

    final response = await http.get(
      Uri.parse('$baseUrl/hello'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('success');
      return true;
    } else {
      print('failed');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    print('AuthService login button pressed　！！');

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('success');
      print((response.body));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.headers['set-cookie']!);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': token!,
      },
    );

    await prefs.remove('token');
  }

// Future<Map<String, dynamic>?> callApiHello() async {
//   // Add a return statement at the end
//   try {
//     // エミュレーターから（ローカルPC内の）dockerコンテナへのアドレスは10.0.2.2となる
//     final response =
//         await http.get(Uri.parse('http://10.0.2.2:15011/api/hello')).timeout(
//       const Duration(seconds: 15),
//       onTimeout: () {
//         throw TimeoutException('The connection has timed out!');
//       },
//     );

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return jsonDecode(response.body);
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to call api');
//     }
//   } on TimeoutException catch (e) {
//     // Handle the timeout exception
//     print(e.message);
//     return null;
//   } catch (e) {
//     // Handle any other exceptions
//     print(e);
//     return null;
//   }
// }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': token!,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
