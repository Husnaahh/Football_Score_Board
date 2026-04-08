import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

import '../../common/common_button.dart';
import '../../common/common_textfield.dart';
import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/user_controller.dart';
import '../../model/user_model.dart';
import '../../service/auth_service.dart';
import '../splash/auth_wrapper.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('FSB', style: AppFontFamily.heading),

              SizedBox(height: 10),

              Text('FOOTBALL SCOREBOARD', style: AppFontFamily.scdheading),

              SizedBox(height: 30),

              CommonTextfield(
                txt: 'NAME',
                controller: nameController,
                obscureTxt: false,
              ),

              SizedBox(height: 21),

              CommonTextfield(
                txt: 'EMAIL',
                controller: emailController,
                obscureTxt: false,
              ),

              SizedBox(height: 20),

              CommonTextfield(
                txt: 'PASSWORD',
                controller: passwordController,
                obscureTxt: true,
              ),

              SizedBox(height: 90),

              Consumer<UserController>(
                builder: (context, userController, child) {
                  return CommonButton(
                    onPressed: () async {
                      final authService = AuthService();

                      try {
                        final user = await authService.registerEmail(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        if (user != null) {
                          final newUser = UserModel(
                            uid: user.uid,
                            name: nameController.text.trim(),
                            email: user.email,
                          );

                          await userController.createUser(newUser);
                        }

                        Fluttertoast.showToast(
                          msg: 'Registration Success',
                          textColor: AppColor.darkGrey,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AuthWrapper()),
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    txt: 'Register',
                  );
                },
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: AppFontFamily.txt),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Login', style: AppFontFamily.rgtbtn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}