import 'package:e_commerce_admin/utils/global_variables.dart';
import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.35,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/loginadmin.jpg'),
              fit: BoxFit.contain
            )
          ),
        ),
       const Text("Login With Your Admin Credentials",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: GlobalVariables.primaryColor),),
       const SizedBox(height: 10),
      ],
    );
  }
}
