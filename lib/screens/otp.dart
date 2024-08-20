// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otpauth/screens/home.dart';


class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {


  final otpController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            "We have sent an OTP to your phone. Plz verify",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 40),

          TextField(
            controller: otpController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.25),
                filled: true,
                hintText: "Enter OTP",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
                  onPressed: () async {
                   

                    try {
                      final cred = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text);

                      await FirebaseAuth.instance.signInWithCredential(cred);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));

                          
                    }
                    
                     catch (e) {
                      log(e.toString());
                    }
                   
                  },

                  
                  child: const Text(
                    "Verify",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ))
        ],
      ),
    ));
  }
}