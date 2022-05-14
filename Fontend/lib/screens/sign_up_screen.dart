import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../custom/error_handler.dart';
import '../models/user_model.dart';
import '../screens/login_screen.dart';
import '../services/authservice.dart';
import '../utils/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  late String email, password;
  final displayNameEditingController = TextEditingController();

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  // reg expression for email validation
  String? validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value)) {
      return 'Please Enter Valid Email!!!';
    } else {
      return null;
    }
  }

  //To Validate password
  String? validatePassword(String value) {
    RegExp regex = RegExp(r'^.{6,}$');
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Password(Min. 6 Character!)';
    }
    return null;
  }

  //To Validate username
  String? validateUsername(String value) {
    RegExp regex = RegExp(r'^.{8,}$');
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Name(Min. 8 Character!)';
    }
    return null;
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Full Name',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autofocus: false,
            controller: displayNameEditingController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onSaved: (value) {
              displayNameEditingController.text = value!;
            },
            validator: (value) =>
                value!.isEmpty ? 'Name is required' : validateUsername(value),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Trueno',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Full Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              email = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Email is required' : validateEmail(value),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Trueno',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autofocus: false,
            obscureText: true,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              password = value;
            },
            validator: (value) => value!.isEmpty
                ? 'Password is required'
                : validatePassword(value),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Trueno',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 40),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          padding: const EdgeInsets.all(15.0),
        ),
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Trueno',
          ),
        ),
        onPressed: () async {
          if (checkFields()) {
            AuthService()
                .signUp(email, password)
                .then((userCreds) {
              postDetailsToFirestore();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }).catchError((e) {
              ErrorHandler().errorDialog(context, e);
            });
          }
        },
      ),
    );
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account ? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Log In',
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Trueno'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      children: const [
        SizedBox(
          height: 150,
          width: 256,
          child: Image(image: AssetImage("assets/images/MangaaroApp.png")),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formKey,
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color(0xFF398AE5),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        _title(),
                        const SizedBox(height: 30.0),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Trueno',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        _buildUsernameTF(),
                        const SizedBox(height: 30.0),
                        _buildEmailTF(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildSignupBtn(),
                        _buildLoginBtn(),
                      ],
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

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.displayName = displayNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully :) ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 25.0);
  }
}
