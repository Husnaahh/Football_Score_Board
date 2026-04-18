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
import '../auth/register_screen.dart';
import '../splash/auth_wrapper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              const SizedBox(height: 10),
              Text('FOOTBALL SCOREBOARD', style: AppFontFamily.scdheading),
              const SizedBox(height: 25),

              CommonTextfield(
                txt: 'EMAIL',
                controller: emailController,
                obscureTxt: false,
              ),
              const SizedBox(height: 20),

              CommonTextfield(
                txt: 'PASSWORD',
                controller: passwordController,
                obscureTxt: true,
              ),

              const SizedBox(height: 40),

              Consumer<UserController>(
                builder: (context, userController, child) {
                  return CommonButton(
                    txt: 'Login',
                    onPressed: () async {
                      final authService = AuthService();

                      try {
                        final user = await authService.loginEmail(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        if (user == null) return;

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => AuthWrapper(),
                        ),
                        );

                        Fluttertoast.showToast(
                          msg: 'Login Success',
                          backgroundColor: Colors.lightGreen,
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 25),

              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 350,
                height: 55,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColor.accentGreen,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    final authService = AuthService();

                    try {
                      final user =
                      await authService.signInWithGoogle(context);

                      if (user == null) return;

                      final userController =
                      Provider.of<UserController>(context, listen: false);

                      final existingUser =
                      await userController.userService.getUser(user.uid);

                      if (existingUser == null) {
                        await userController.createUser(
                          UserModel(
                            uid: user.uid,
                            name: user.displayName ?? '',
                            email: user.email ?? '',
                            role: 'user',
                          ),
                        );
                      } else {
                        await userController.loadUser(user.uid);
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthWrapper(),
                        ),
                      );
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  },
                  icon: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
                    height: 22,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                  ),
                  label: const Text(
                    "Continue with Google",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.accentGreen,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppFontFamily.txt,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Register now',
                      style: AppFontFamily.rgtbtn,
                    ),
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