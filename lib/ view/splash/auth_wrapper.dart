import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/user_controller.dart';
import '../admin/admin_main_screen.dart';
import '../auth/login_screen.dart';
import '../home/widget/main_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) return LoginScreen();

        return FutureBuilder(
          future: Provider.of<UserController>(context, listen: false)
              .loadUser(snapshot.data!.uid),
          builder: (context, _) {
            return Consumer<UserController>(
              builder: (context, userController, child) {
                if (userController.userModel == null) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                if (userController.userModel!.role == 'admin') {
                  return const AdminMainScreen();
                } else {
                  return const MainScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}