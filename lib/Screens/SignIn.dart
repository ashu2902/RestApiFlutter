import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email = '', _password = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Authentication'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 60),
                child: Container(
                  child: Text(
                    'Sign In to Continue',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Container(
                width: _width / 1.5,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _email = value.trim().toLowerCase();
                  },
                ),
              ),
              SizedBox(
                height: _height / 69,
              ),
              Container(
                width: _width / 1.5,
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _password = value.trim();
                  },
                ),
              ),
              SizedBox(
                height: _height / 69,
              ),
              Container(
                height: _height / 20,
                width: _width / 2.5,
                child: ElevatedButton(
                  child: Text('Sign In '),
                  onPressed: () {
                    signIn(_email, _password);
                    _emailController.clear();
                    _passwordController.clear();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AdminSplashScreen()));
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: Divider(
                  thickness: 1.5,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextButton(
                    onPressed: () => signInWithGoogle(),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        child: Center(
                          child: Text(
                            'Sign In with Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }

  signIn(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
      if (auth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        print('User Signed In');
      }
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: "${error.message}",
          gravity: ToastGravity.TOP,
          fontSize: 20,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['email']).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    print(credential);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
