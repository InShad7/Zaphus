import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zaphus/controller/provider/contoller.dart';
import 'package:zaphus/view/home_screen/home_screen.dart';
import 'package:zaphus/view/login_screen/widget/custom_text_field.dart';
import 'package:zaphus/view/utils/constants.dart';

import '../utils/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ControllerProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ControllerProvider>(context);
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey2,
            child: Column(
              children: [
                Image.asset('assets/zaphus.png'),
                const Text(
                  'Welcomes you!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHeight30,
                MyTextField(
                  title: 'Name',
                  myControler: provider.nameController,
                  isEditable: provider.isEditMode,
                  isNumber: false,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Name can\'t be empty';
                    }
                    return null; // No error
                  },
                ),
                MyTextField(
                  title: '+91| Mobile Number',
                  myControler: provider.phoneController,
                  isEditable: provider.isEditMode,
                  isNumber: true,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Number can\'t be empty';
                    } else if (val.length != 10) {
                      return 'Please enter a 10-digit number';
                    }
                    return null; // No error
                  },
                ),
                kHeight30,
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: MediaQuery.of(context).size.height / 17,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (provider.isEditMode) {
                        // If in edit mode, save the user data
                        if (formKey2.currentState!.validate()) {
                          provider.saveUserData(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Enter valid credentials',
                            backgroundColor: red,
                          );
                        }
                      } else {
                        provider.toggleEditMode();
                      }
                    },
                    child: Text(
                      provider.isEditMode ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
