import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_task/services/firebase_services/firebase_store/firebase_store.dart';
import 'package:flutter_task/utils/app_color.dart';
import 'package:flutter_task/utils/app_validation.dart';
import 'package:flutter_task/widgets/custom_container_buttom.dart';
import 'package:flutter_task/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final data = await FirebaseStore.getData();

    if (data != null) {
      setState(() {
        firstNameController.text = data['firstName'] ?? '';
        middleNameController.text = data['middleName'] ?? '';
        lastNameController.text = data['lastName'] ?? '';
        emailController.text = data['email'] ?? '';
        genderController.text = data['gender'] ?? '';
        ageController.text = data['age'] ?? '';
        passwordController.text = data['password'] ?? '';
        phoneController.text = data['phoneNumber'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Information',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.blueColor,
        centerTitle: true,
      ),
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
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          CustomTextField(
                            emailController: firstNameController,
                            hintText: 'First Name',
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(Icons.person_rounded),
                            validator: (p0) {
                              return AppValidation.validation(
                                type: AppValidationType.username,
                                username: p0,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            emailController: middleNameController,
                            hintText: 'Middle Name',
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(Icons.person_rounded),
                            validator: (p0) {
                              return AppValidation.validation(
                                type: AppValidationType.username,
                                username: p0,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            emailController: lastNameController,
                            hintText: 'Last Name',
                            keyboardType: TextInputType.text,
                            suffixIcon: Icon(Icons.person_rounded),
                            validator: (p0) {
                              return AppValidation.validation(
                                type: AppValidationType.username,
                                username: p0,
                              );
                            },
                          ),
                          SizedBox(height: 10),
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
                            emailController: genderController,
                            hintText: 'Gender',
                            keyboardType: TextInputType.emailAddress,
                            suffixIcon: Icon(Icons.person),
                            validator: (p0) {
                              return AppValidation.validation(
                                type: AppValidationType.username,
                                username: p0,
                              );
                            },
                          ),

                          SizedBox(height: 10),
                          CustomTextField(
                            emailController: ageController,
                            hintText: 'Age',
                            keyboardType: TextInputType.number,
                            suffixIcon: Icon(Icons.numbers),
                            validator: (p0) {
                              return AppValidation.validation(
                                type: AppValidationType.phone,
                                phone: p0,
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
                          SizedBox(height: 10),
                          CustomTextField(
                            emailController: phoneController,
                            hintText: 'Phone Number',
                            keyboardType: TextInputType.phone,
                            suffixIcon: Icon(Icons.phone),
                            validator: (p0) {
                              return AppValidation.validation(
                                type: AppValidationType.phone,
                                phone: p0,
                              );
                            },
                          ),
                          SizedBox(height: 15),

                          SizedBox(height: 15),
                          CustomContainerButtom(
                            text: 'Save ',
                            onTap: () {
                              try {
                                FirebaseStore.updateUserProfile(
                                  firstName: firstNameController.text,
                                  middleName: middleNameController.text,
                                  lastName: lastNameController.text,
                                  age: ageController.text,
                                  gender: genderController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              } on Exception catch (e) {
                                log(e.toString());
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          CustomContainerButtom(
                            text: 'Delete Account',
                            onTap: () {
                              try {
                                FirebaseStore.deleteUserAccount();
                              } on Exception catch (e) {
                                log(e.toString());
                              }
                            },
                          ),
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
    );
  }
}
