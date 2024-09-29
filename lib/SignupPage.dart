import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'HomePage.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  int index = 0;
  bool status = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool otpVerified = false;

  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Signup",
                  style: GoogleFonts.sofia(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 90),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Stepper(
                  controlsBuilder: (context, details) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            if (index == 0) {
                              if (_formKeyPhone.currentState!.validate()) {
                                setState(() {
                                  index++;
                                });
                              }
                            } else if (index == 1) {
                              if (otpController.text.length == 4) {
                                setState(() {
                                  index++;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Please enter a valid 4-digit OTP')),
                                );
                              }
                            } else if (index == 2) {
                              if (_formKeyPassword.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (builder) {
                                    return HomePage();
                                  }));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Passwords do not match')),
                                  );
                                }
                              }
                            }
                          },
                          color: Colors.white,
                          child: const Text("Continue"),
                        ),
                      ],
                    );
                  },
                  currentStep: index,
                  connectorThickness: 4,
                  steps: [
                    Step(
                      stepStyle: StepStyle(
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      title: Text(
                        "Phone Number",
                        style: GoogleFonts.sofia(
                            fontSize: 20, color: Colors.white),
                      ),
                      content: Form(
                        key: _formKeyPhone,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: phoneController,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.sofia(
                                  fontSize: 20, color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.phone,
                                    color: Colors.white),
                                labelText: "Phone Number",
                                labelStyle: GoogleFonts.sofia(
                                    fontSize: 20, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                  return 'Please enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      stepStyle: StepStyle(
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      title: Text(
                        "OTP Verification",
                        style: GoogleFonts.sofia(
                            fontSize: 20, color: Colors.white),
                      ),
                      content: Column(
                        children: [
                          Pinput(
                            controller: otpController,
                            defaultPinTheme: PinTheme(
                              textStyle: GoogleFonts.sofia(
                                  fontSize: 20, color: Colors.white),
                              width: 50,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border:
                                    Border.all(width: 3, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Step(
                      stepStyle: StepStyle(
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      title: Text(
                        "Password Setup",
                        style: GoogleFonts.sofia(
                            fontSize: 20, color: Colors.white),
                      ),
                      content: Form(
                        key: _formKeyPassword,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: passwordController,
                              style: GoogleFonts.sofia(
                                  fontSize: 20, color: Colors.white),
                              cursorColor: Colors.white,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: GoogleFonts.sofia(
                                    fontSize: 20, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6 || value.length > 12) {
                                  return 'Password must be 6-12 characters long';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: confirmPasswordController,
                              style: GoogleFonts.sofia(
                                  fontSize: 20, color: Colors.white),
                              cursorColor: Colors.white,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: GoogleFonts.sofia(
                                    fontSize: 20, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
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
          ],
        ),
      ),
    );
  }
}
