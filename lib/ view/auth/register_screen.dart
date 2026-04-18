import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../common/common_button.dart';
import '../../common/common_textfield.dart';
import '../../constant/admin_constant.dart';
import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/user_controller.dart';
import '../../model/user_model.dart';
import '../../service/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = 'user';

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

              Text('FOOTBALL SCOREBOARD',
                  style: AppFontFamily.scdheading),

              const SizedBox(height: 30),

              CommonTextfield(
                txt: 'NAME',
                controller: nameController,
                obscureTxt: false,
              ),

              const SizedBox(height: 20),

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

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Register as: ", style: AppFontFamily.txt),

                  Row(
                    children: [
                      Radio<String>(
                        value: 'user',
                        groupValue: selectedRole,
                        activeColor: AppColor.accentGreen,
                        onChanged: (value) {
                          setState(() => selectedRole = value!);
                        },
                      ),
                      Text("User", style: AppFontFamily.txt),
                    ],
                  ),

                  Row(
                    children: [
                      Radio<String>(
                        value: 'admin',
                        groupValue: selectedRole,
                        activeColor: AppColor.accentGreen,
                        onChanged: (value) {
                          setState(() => selectedRole = value!);
                        },
                      ),
                      Text("Admin", style: AppFontFamily.txt),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Consumer<UserController>(
                builder: (context, userController, child) {
                  return CommonButton(
                    txt: 'Register',
                    onPressed: () async {
                      final authService = AuthService();

                      try {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        final isAdminEmail = adminEmails.contains(email);

                        // ✅ VALIDATION
                        if (selectedRole == 'admin' && !isAdminEmail) {
                          Fluttertoast.showToast(msg: "Only admin emails allowed");
                          return;
                        }

                        if (selectedRole == 'user' && isAdminEmail) {
                          Fluttertoast.showToast(msg: "Admin must register as admin");
                          return;
                        }

                        print("ROLE SELECTED: $selectedRole");

                        // ✅ CREATE AUTH USER
                        final user = await authService.registerEmail(
                          name,
                          email,
                          password,
                        );

                        if (user == null) return;

                        final newUser = UserModel(
                          uid: user.uid,
                          name: name,
                          email: email,
                          role: selectedRole,
                        );

                        await Provider.of<UserController>(context, listen: false)
                            .createUser(newUser);

                        Fluttertoast.showToast(msg: "Registration Success");

                        // ✅ NAVIGATE
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );

                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: AppFontFamily.txt),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                           LoginScreen(),
                        ),
                      );
                    },
                    child: Text('Login',
                        style: AppFontFamily.rgtbtn),
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