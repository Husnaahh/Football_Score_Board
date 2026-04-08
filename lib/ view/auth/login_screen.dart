import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:football_scoreboared/%20view/auth/register_screen.dart';
import 'package:provider/provider.dart';

import '../../common/common_button.dart';
import '../../common/common_textfield.dart';
import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/user_controller.dart';
import '../../service/auth_service.dart';
import '../splash/auth_wrapper.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('FSB', style: AppFontFamily.heading),

            SizedBox(height: 10),

            Text('FOOTBALL SCOREBOARD', style: AppFontFamily.scdheading),

            SizedBox(height: 25),

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
                      final user =  await authService.loginEmail(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if(user != null) {
                        await userController.loaddUser(user.uid);
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AuthWrapper()),
                      );

                      Fluttertoast.showToast(
                        msg: 'Login Success',
                        textColor: AppColor.darkGrey,
                      );
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  },
                  txt: 'Login',
                );
              },
            ),

            SizedBox(height: 30),



            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don`t have an account?', style: AppFontFamily.txt),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Register now', style: AppFontFamily.rgtbtn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}