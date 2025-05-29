import 'package:intl/intl.dart';

class SignupLogic {
  String firstName = '';
  String surname = '';
  DateTime? dateOfBirth;
  String gender = 'Nữ';
  bool isCustomGender = false;
  String customGender = '';
  String email = '';
  String password = '';
  String? errorMessage;

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) return 'Họ là bắt buộc';
    if (!RegExp(r'^[a-zA-Z\s-]+$').hasMatch(value)) return 'Họ không hợp lệ';
    if (value.length > 50) return 'Họ không được vượt quá 50 ký tự';
    return null;
  }

  String? validateSurname(String? value) {
    if (value == null || value.isEmpty) return 'Tên là bắt buộc';
    if (!RegExp(r'^[a-zA-Z\s-]+$').hasMatch(value)) return 'Tên không hợp lệ';
    if (value.length > 50) return 'Tên không được vượt quá 50 ký tự';
    return null;
  }

  String? validateDateOfBirth(DateTime? value) {
    if (value == null) return 'Ngày sinh là bắt buộc';
    if (value.isAfter(DateTime.now())) return 'Ngày sinh không thể ở tương lai';
    DateTime ageLimit = DateTime(2012, 5, 29); // 13 years before today (29/5/2025)
    if (value.isAfter(ageLimit)) return 'Bạn phải ít nhất 13 tuổi';
    return null;
  }

  String? validateGender(String? value) {
    if (value == null) return 'Vui lòng chọn giới tính';
    if (isCustomGender && (customGender.isEmpty || customGender.length > 20)) {
      return 'Giới tính tùy chỉnh là bắt buộc và không được vượt quá 20 ký tự';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Số di động hoặc email là bắt buộc';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value) &&
        !RegExp(r'^(?:\+84|0)[1-9][0-9]{8,9}$').hasMatch(value)) {
      return 'Vui lòng nhập email hoặc số điện thoại hợp lệ';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Mật khẩu là bắt buộc';
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value)) {
      return 'Mật khẩu phải dài ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt';
    }
    return null;
  }

  Future<bool> submitForm() async {
    errorMessage = null;
    if (validateFirstName(firstName) != null ||
        validateSurname(surname) != null ||
        validateDateOfBirth(dateOfBirth) != null ||
        validateGender(gender) != null ||
        validateEmail(email) != null ||
        validatePassword(password) != null) {
      return false;
    }

    // Logic giả lập: Nếu tất cả dữ liệu hợp lệ, giả định đăng ký thành công
    await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian xử lý
    if (firstName.isNotEmpty && surname.isNotEmpty && dateOfBirth != null && email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      errorMessage = 'Dữ liệu không hợp lệ, vui lòng kiểm tra lại';
      return false;
    }
  }

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'firstName':
        firstName = value;
        break;
      case 'surname':
        surname = value;
        break;
      case 'dateOfBirth':
        dateOfBirth = value;
        break;
      case 'gender':
        gender = value;
        isCustomGender = value == 'Tùy chỉnh';
        break;
      case 'customGender':
        customGender = value;
        break;
      case 'email':
        email = value;
        break;
      case 'password':
        password = value;
        break;
    }
  }
}