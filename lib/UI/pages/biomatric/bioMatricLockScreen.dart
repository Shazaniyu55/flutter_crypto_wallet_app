// ignore_for_file: must_be_immutable, file_names, sized_box_for_whitespace, empty_catches, deprecated_member_use, use_super_parameters

import 'package:benex/UI/pages/biomatric/passwordLockScreen.dart';
import 'package:benex/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:local_auth/local_auth.dart';

class BioMatricLockScreen extends StatefulWidget {
  BioMatricLockScreen({Key? key, this.fromPage}) : super(key: key);
  String? fromPage;

  @override
  State<BioMatricLockScreen> createState() => _BioMatricLockScreenState();
}

class _BioMatricLockScreenState extends State<BioMatricLockScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Color(0x0D27C19F)),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                    fontFamily: 'sfpro',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 26.0,
                    letterSpacing: 0.37,
                    color: headingColor.value),
              ),

              // SizedBox(height: 100),

              Column(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: SvgPicture.asset(
                        "assets/svgs/biometric.svg",
                        color: primaryColor.value,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Touch ID to Open Crypto Wallet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'sfpro',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        letterSpacing: 0.37,
                        color: primaryColor.value),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(PasswordLockScreen(
                        fromPage: widget.fromPage ?? '',
                      ));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        'Use Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'sfpro',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            letterSpacing: 0.37,
                            color: primaryColor.value),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      authenticate();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        'Try Again!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'sfpro',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            letterSpacing: 0.37,
                            color: primaryColor.value),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  authenticate() async {
    try {
      await auth.stopAuthentication();
    } on PlatformException {}
  }
}
