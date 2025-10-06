import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/cubits/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:flutter_task/models/cubits/firebase_auth_cubit/firebase_auth_cubit_state.dart';
import 'package:flutter_task/screens/home_screen/home_screen.dart';
import 'package:flutter_task/screens/resgister_screen/register_screen.dart';
import 'package:flutter_task/services/firebase_services/firebase_store/firebase_store.dart';
import 'package:flutter_task/utils/app_color.dart';
import 'package:flutter_task/utils/app_validation.dart';
import 'package:flutter_task/widgets/custom_container_buttom.dart';
import 'package:flutter_task/widgets/custom_register_with_icon.dart';
import 'package:flutter_task/widgets/custom_remember_me_and_forget_password.dart';
import 'package:flutter_task/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirebaseAuthCubit, FirebaseAuthCubitState>(
      listener: (context, state) {
        if (state is FirebaseAuthCubitLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is FirebaseAuthCubitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.pop(context);
        } else if (state is FirebaseAuthCubitSuccess) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return HomeScreen();
              },
              transitionDuration: Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          );
        }
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: AppColor.blueColor),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            CustomRegisterWithIcon(),
                            SizedBox(height: 10),
                            Text(
                              'or use your email account to login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                            CustomTextField(
                              emailController: emailController,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              suffixIcon: Icon(Icons.email_outlined),
                              validator: (p0) {
                                return AppValidation.validation(
                                  type: AppValidationType.email,
                                  email: p0,
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              emailController: passwordController,
                              hintText: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                              suffixIcon: Icon(Icons.lock),
                              obscureText: true,
                              validator: (p0) {
                                return AppValidation.validation(
                                  type: AppValidationType.password,
                                  password: p0,
                                );
                              },
                            ),

                            SizedBox(height: 15),
                            CustomRememberMeAndForgetPassword(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              text1: 'Remember Me',
                              text2: ' Forget Password',
                            ),
                            SizedBox(height: 15),
                            CustomContainerButtom(
                              text: 'Login',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    FirebaseStore.addUserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    context.read<FirebaseAuthCubit>().login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  } on Exception catch (e) {
                                    print(e);
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            CustomRememberMeAndForgetPassword(
                              mainAxisAlignment: MainAxisAlignment.center,
                              text1: 'Don\'t have an account? ',
                              text2: 'Register',
                              fontWeight: FontWeight.bold,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
