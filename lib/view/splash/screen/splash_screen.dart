import 'package:e_commerce_admin/controllers/user_provider.dart';
import 'package:e_commerce_admin/services/auth_service.dart';
import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:e_commerce_admin/view/auth/screens/sign_in_screen.dart';
import 'package:e_commerce_admin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../admin/screen/admin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    _auth.getUserData(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
               WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<UserProvider>(context,listen: false).user.token.isNotEmpty
                  && Provider.of<UserProvider>(context,listen: false).user.type == 'admin' ?
                    Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminScreen(),
                          ),
                        )
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
               });
            return const Scaffold(body: Loader());
          } else {
            return const NewSplashScreen();
          }
        });
  }
}

class NewSplashScreen extends StatelessWidget {
  const NewSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "IShopTech",
          style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: GlobalVariables.primaryColor),
        ),
      ),
    );
  }
}
