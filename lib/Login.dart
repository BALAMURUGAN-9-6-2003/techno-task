import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:techno/HomePage.dart';
import 'package:techno/SignupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isOtpLogin = false;
  bool otpRequested = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
    otpController.dispose();
  }

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
                  "Login",
                  style: GoogleFonts.sofia(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white10,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: phoneController,
                                  style: GoogleFonts.sofia(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    error: null,
                                    errorStyle: GoogleFonts.sofia(
                                      fontSize: 13,
                                      color: Colors.red,
                                    ),
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.phone,
                                      color: Colors.white,
                                    ),
                                    labelText: "Phone Number",
                                    labelStyle: GoogleFonts.sofia(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    } else if (value.length != 10) {
                                      return 'Phone number must be exactly 10 digits';
                                    } else if (!RegExp(r'^[0-9]+$')
                                        .hasMatch(value)) {
                                      return 'Only numbers are allowed';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                isOtpLogin
                                    ? otpRequested
                                        ? Pinput(
                                            // OTP input field
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            controller: otpController,
                                            defaultPinTheme: PinTheme(
                                              textStyle: GoogleFonts.sofia(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              width: 50,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                border: Border.all(
                                                    width: 3,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            // Request OTP button
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  otpRequested = true;
                                                });
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 50),
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 25, vertical: 10),
                                              child: Text(
                                                "Request OTP",
                                                style: GoogleFonts.sofia(
                                                    fontSize: 25),
                                              ),
                                            ),
                                          )
                                    : TextFormField(
                                        controller: passwordController,
                                        style: GoogleFonts.sofia(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          error: null,
                                          errorStyle: GoogleFonts.sofia(
                                            fontSize: 13,
                                            color: Colors.red,
                                          ),
                                          prefixIcon: const Icon(
                                            FontAwesomeIcons.lock,
                                            color: Colors.white,
                                          ),
                                          labelText: "Password",
                                          labelStyle: GoogleFonts.sofia(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          } else if (value.length < 6 ||
                                              value.length > 12) {
                                            return 'Password must be between 6 to 12 characters';
                                          }
                                          return null;
                                        },
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              if (isOtpLogin) {
                                if (otpRequested &&
                                    otpController.text.isNotEmpty) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                                }
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                                }
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text(
                                isOtpLogin ? "Submit OTP" : "Log in",
                                style: GoogleFonts.sofia(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isOtpLogin = !isOtpLogin;
                                otpRequested = false;
                              });
                            },
                            child: Text(
                              isOtpLogin
                                  ? "Switch to Phone & Password Login"
                                  : "Switch to Phone & OTP Login",
                              style: GoogleFonts.sofia(
                                fontSize: 18,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Signuppage(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.sofia(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
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
