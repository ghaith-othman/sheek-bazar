import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/auth_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: 1.sh,
          child: Stack(
            children: [
              ClipRRect(
                child: Image.asset("assets/images/sign_up.png"),
              ),
              const FormContainerForSignUp(),
              const FloationgIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
