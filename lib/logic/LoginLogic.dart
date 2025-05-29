class LoginLogic {
  String email = '';
  String password = '';
  String? errorMessage;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email hoặc số điện thoại là bắt buộc';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value) &&
        !RegExp(r'^(?:\+84|0)[1-9][0-9]{8,9}$').hasMatch(value)) {
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

    // Logic giả lập: Nếu email và password không rỗng, giả định đăng nhập thành công
    await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian xử lý
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      errorMessage = 'Email hoặc mật khẩu không hợp lệ';
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