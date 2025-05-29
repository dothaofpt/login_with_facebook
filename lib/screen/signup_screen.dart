import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../logic/signup_logic.dart';
import './login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupLogic _logic = SignupLogic();
  final _formKey = GlobalKey<FormState>();
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;
  List<int> days = List.generate(31, (index) => index + 1);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(125, (index) => DateTime.now().year - index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListView(
            children: [
              // Centered Facebook logo
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Center(
                  child: Text(
                    'facebook',
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xFF1877F2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Form container with shadow
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and subtitle
                      Text(
                        'Tạo tài khoản mới',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Nhanh chóng và dễ dàng.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 12),
                      // First name and surname
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Họ',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              onChanged: (value) => _logic.updateField('firstName', value),
                              validator: (value) => _logic.validateFirstName(value),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Tên',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              onChanged: (value) => _logic.updateField('surname', value),
                              validator: (value) => _logic.validateSurname(value),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Date of Birth
                      Text('Ngày sinh ?', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: selectedDay,
                              hint: Text('28', style: TextStyle(fontSize: 14)),
                              items: days.map((int day) {
                                return DropdownMenuItem<int>(
                                  value: day,
                                  child: Text(day.toString(), style: TextStyle(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDay = value;
                                  _updateDateOfBirth();
                                });
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              validator: (value) => selectedDay == null ? 'Vui lòng chọn ngày' : null,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: selectedMonth,
                              hint: Text('Tháng 5', style: TextStyle(fontSize: 14)),
                              items: months.map((int month) {
                                return DropdownMenuItem<int>(
                                  value: month,
                                  child: Text('Tháng $month', style: TextStyle(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedMonth = value;
                                  _updateDateOfBirth();
                                });
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              validator: (value) => selectedMonth == null ? 'Vui lòng chọn tháng' : null,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: selectedYear,
                              hint: Text('2025', style: TextStyle(fontSize: 14)),
                              items: years.map((int year) {
                                return DropdownMenuItem<int>(
                                  value: year,
                                  child: Text(year.toString(), style: TextStyle(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedYear: value;
                                  _updateDateOfBirth();
                                });
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              validator: (value) => selectedYear == null ? 'Vui lòng chọn năm' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Gender selection
                      Text('Giới tính ?', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Nữ',
                                  groupValue: _logic.gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _logic.updateField('gender', value);
                                      _logic.isCustomGender = false;
                                    });
                                  },
                                ),
                                Text('Nữ', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Nam',
                                  groupValue: _logic.gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _logic.updateField('gender', value);
                                      _logic.isCustomGender = false;
                                    });
                                  },
                                ),
                                Text('Nam', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Tùy chỉnh',
                                  groupValue: _logic.gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _logic.updateField('gender', value);
                                      _logic.isCustomGender = true;
                                    });
                                  },
                                ),
                                Text('Tùy chỉnh', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (_logic.isCustomGender)
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Giới tính tùy chỉnh',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          onChanged: (value) => _logic.updateField('customGender', value),
                          validator: (value) => _logic.validateGender(_logic.gender),
                        ),
                      SizedBox(height: 12),
                      // Mobile number or email
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Số di động hoặc email',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onChanged: (value) => _logic.updateField('email', value),
                        validator: (value) => _logic.validateEmail(value),
                      ),
                      SizedBox(height: 12),
                      // Password
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu mới',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF1877F2), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        obscureText: true,
                        onChanged: (value) => _logic.updateField('password', value),
                        validator: (value) => _logic.validatePassword(value),
                      ),
                      SizedBox(height: 12),
                      // Informational text
                      Text(
                        'Những người dùng dịch vụ của chúng tôi có thể đã tải thông tin liên hệ của bạn lên Facebook. Tìm hiểu thêm.',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Bằng cách nhấn vào Đăng ký, bạn đồng ý với Điều khoản, Chính sách quyền riêng tư và Chính sách cookie của chúng tôi. Bạn có thể nhận được thông báo của chúng tôi qua SMS và hủy nhận bất kỳ lúc nào.',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 16),
                      // Sign Up button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00A400),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool success = await _logic.submitForm();
                              if (success) {
                                Navigator.pushReplacementNamed(context, '/home');
                              } else if (_logic.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(_logic.errorMessage!)),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      // Already have an account link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Bạn đã có tài khoản ư?',
                            style: TextStyle(color: Color(0xFF1877F2), fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateDateOfBirth() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      try {
        _logic.updateField(
          'dateOfBirth',
          DateTime(selectedYear!, selectedMonth!, selectedDay!),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ngày không hợp lệ!')),
        );
        setState(() {
          selectedDay = null;
          selectedMonth = null;
          selectedYear = null;
        });
      }
    }
  }
}