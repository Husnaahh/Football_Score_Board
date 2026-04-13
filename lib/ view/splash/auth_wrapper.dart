import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/user_controller.dart';
import '../admin/admin_dashboard.dart';
import '../auth/login_screen.dart';
import '../home/widget/main_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool loading = false;

  Future<void> loadUser(UserController controller, String uid) async {
    if (!loading) {
      loading = true;
      await controller.loadUser(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return LoginScreen();
        }

        final firebaseUser = snapshot.data!;

        return Consumer<UserController>(
          builder: (context, controller, child) {

            if (controller.userModel == null ||
                controller.userModel!.uid != firebaseUser.uid) {

              loadUser(controller, firebaseUser.uid);

              return const Scaffold(
                body: Center(),
              );
            }

            final user = controller.userModel!;

            print("ROLE: ${user.role}");

            if (user.role.trim().toLowerCase() == "admin") {
              return const AdminDashboard();
            }

            return const MainScreen();
          },
        );
      },
    );
  }
}