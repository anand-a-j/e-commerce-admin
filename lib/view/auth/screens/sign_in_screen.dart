import 'package:e_commerce_admin/controllers/auth_provider.dart';
import 'package:e_commerce_admin/utils/dimensions.dart';
import 'package:e_commerce_admin/utils/utils.dart';
import 'package:e_commerce_admin/view/auth/widgets/login_title.dart';
import 'package:e_commerce_admin/widgets/custom_button.dart';
import 'package:e_commerce_admin/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInFormBody(
          signInFormKey: _signInFormKey,
          emailController: _emailController,
          passwordController: _passwordController
          ),
    );
  }
}

class SignInFormBody extends StatelessWidget {
  const SignInFormBody({
    super.key,
    required GlobalKey<FormState> signInFormKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _signInFormKey = signInFormKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _signInFormKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginTitle(),
              Dimensions.kHeight10,
              CustomTextField(
                controller: _emailController,
                hintText: "Email",
                inputType: TextInputType.emailAddress,
                isScrollNeed: true,
              ),
              Dimensions.kHeight10,
              CustomTextField(
                controller: _passwordController,
                hintText: "Password",
                isPass: true,
                isScrollNeed: true,
              ),
              Dimensions.kHeight20,
              Consumer<AuthProvider>(builder: (context, authProvider, child) {
                return CustomButton(
                    isLoading: authProvider.isLoading,
                    title: "Login",
                    onPressed: () {
                      if (_passwordController.text.length <= 6) {
                        showSnackBar(context,
                            "Password length should be greater that 6 charaters");
                      } else {
                        if (_signInFormKey.currentState!.validate()) {
                          authProvider.signInUser(
                              context: context,
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim());
                        }
                      }
                    });
              }),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
