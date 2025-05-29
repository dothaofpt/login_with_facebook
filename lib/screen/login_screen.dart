import 'package:flutter/material.dart';
import '../logic/LoginLogic.dart';
import './signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginLogic _logic = LoginLogic();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Reduced vertical padding
          child: ListView(
            children: [
              // Centered Facebook logo
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0), // Reduced padding
                child: Center(
                  child: Text(
                    'facebook',
                    style: TextStyle(
                      fontSize: 32, // Reduced font size
                      color: Color(0xFF1877F2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Form container with shadow
              Container(
                padding: EdgeInsets.all(12.0), // Reduced padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Softer shadow
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
                      // Title
                      Text(
                        'Đăng nhập Facebook',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Reduced font size
                      ),
                      SizedBox(height: 12), // Reduced spacing
                      // Email or phone number
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email hoặc số điện thoại',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!), // Lighter border
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!), // Lighter border
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF1877F2), width: 2), // Blue focus
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: EdgeInsets.symmetric(vertical: 10), // Reduced height
                        ),
                        onChanged: (value) => _logic.updateField('email', value),
                        validator: (value) => _logic.validateEmail(value),
                      ),
                      SizedBox(height: 12), // Reduced spacing
                      // Password
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!), // Lighter border
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!), // Lighter border
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF1877F2), width: 2), // Blue focus
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: EdgeInsets.symmetric(vertical: 10), // Reduced height
                        ),
                        obscureText: true,
                        onChanged: (value) => _logic.updateField('password', value),
                        validator: (value) => _logic.validatePassword(value),
                      ),
                      SizedBox(height: 16), // Reduced spacing
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1877F2),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12), // Reduced button height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0), // Slightly smaller radius
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
                            'Đăng nhập',
                            style: TextStyle(fontSize: 14), // Reduced font size
                          ),
                        ),
                      ),
                      SizedBox(height: 12), // Reduced spacing
                      // Forgot account and sign up links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Chức năng quên tài khoản chưa được triển khai')),
                              );
                            },
                            child: Text(
                              'Bạn quên tài khoản ư?',
                              style: TextStyle(color: Color(0xFF1877F2), fontSize: 12), // Reduced font size
                            ),
                          ),
                          Text(' • '),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              'Đăng ký Facebook',
                              style: TextStyle(color: Color(0xFF1877F2), fontSize: 12), // Reduced font size
                            ),
                          ),
                        ],
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
}