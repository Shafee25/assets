import 'package:firebaseapp/screens/login_screen.dart';
import 'package:firebaseapp/services/authentication.dart';
import 'package:firebaseapp/widgets/snackbar.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/text_field.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }


  void signupUser() async {
    String res = await AuthServices().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
    );

    if(res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 22,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height/2.7,
                child: Image.asset("images/signup.png"),
              ),
              TextFieldInput(
                textEditingController: nameController,
                hintText: "Enter your name",
                icon: Icons.person,
              ),
              TextFieldInput(
                textEditingController: emailController,
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              TextFieldInput(
                isPass: true,
                textEditingController: passwordController,
                hintText: "Enter your password",
                icon: Icons.lock,
              ),

              MyButton(
                  onTap: signupUser,
                  text: "Sign Up"
              ),
              SizedBox(
                height: height/45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen(),
                          ),
                      );
                    },
                    child: const Text(
                      " Log In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
