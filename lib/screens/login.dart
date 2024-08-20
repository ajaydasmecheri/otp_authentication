import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otpauth/screens/otp.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final phoneController = TextEditingController();
  final String code ="+91";

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const Text(
              "OTP Phone Authentication",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            
        
            const SizedBox(height: 40),


            TextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.25),
                  filled: true,
                  hintText: "Enter Phone",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
            ),


            const SizedBox(height: 20),

             ElevatedButton(
                    onPressed: () async {
                     

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: code+phoneController.text,

                        

                        verificationCompleted: (phoneAuthCredential) {},

                        verificationFailed: (error) {
                          log(error.toString());
                        },

                        codeSent: (verificationId, forceResendingToken) {
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPScreen(
                                        verificationId: verificationId,
                                      )));
                        },

                        codeAutoRetrievalTimeout: (verificationId) {
                          log("Auto Retireval timeout");
                        },

                      );

                      print(code+phoneController.text);
                    },
                    child: const Text(
                      "Sign in",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ))
          ],
        ),
      ),
    );
  }
}