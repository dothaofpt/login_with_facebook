import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginLogic {
  String email = '';
  String password = '';
  String? errorMessage;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email hoặc số điện thoại là bắt buộc';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value) &&
        !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'Vui lòng nhập email hoặc số điện thoại hợp lệ';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Mật khẩu là bắt buộc';
    return null; // Basic validation; adjust as needed
  }

  Future<bool> submitForm() async {
    errorMessage = null;
    if (validateEmail(email) != null || validatePassword(password) != null) {
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.example.com/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password, // Should be hashed in production
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        errorMessage = 'Đăng nhập thất bại: ${response.body}';
        return false;
      }
    } catch (e) {
      errorMessage = 'Không có kết nối internet';
      return false;
    }
  }

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'email':
        email = value;
        break;
      case 'password':
        password = value;
        break;
    }
  }
}