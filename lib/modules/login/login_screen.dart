 import 'package:cousre_code/shared/componants/componants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey= GlobalKey<FormState>();
  bool isPassword=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40,),
                  defaultFormField(
                    controller: emailController,
                    label: "E-Mail",
                    validate: (String value){
                      if(value.isEmpty){
                        return "email must not be empty";
                      }
                      return null;
                    },
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,

                  ),
                  SizedBox(height: 20,),
                  defaultFormField(
                      controller: passwordController,
                      label: "PassWord",
                      validate: (String value){
                        if(value.isEmpty){
                          return "email must not be empty";
                        }
                        return null;
                      },
                      prefix: Icons.lock,
                      type: TextInputType.visiblePassword,
                      suffix:isPassword?Icons.remove_red_eye:Icons.visibility_off,
                      isPassword: isPassword,
                      suffixPressed: (){
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }
                  ),
                  SizedBox(height: 20,),
                  defaultButton(
                    function: (){
                      if(formKey.currentState.validate()){
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                    text: "login",
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have an account?",),
                      TextButton(
                        onPressed: (){},
                        child: Text("Register?"),
                      ),
                    ],
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
