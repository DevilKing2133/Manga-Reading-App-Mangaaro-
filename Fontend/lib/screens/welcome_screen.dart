import 'package:flutter/material.dart';
import '../custom/fade_animation.dart';

import '../screens/login_screen.dart';
import '../screens/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: 500,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill
              )
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 40,
                  width: 80,
                  height: 180,
                  child: FadeAnimation(1, Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/light-1.png')
                      )
                    ),
                  )),
                ),
                Positioned(
                  left: 150,
                  width: 80,
                  height: 150,
                  child: FadeAnimation(1.3, Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/light-2.png')
                      )
                    ),
                  )),
                ),
                Positioned(
                  right: 40,
                  top: 40,
                  width: 80,
                  height: 150,
                  child: FadeAnimation(1.5, Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/clock.png')
                      )
                    ),
                  )),
                ),
                  Positioned(
                    child: FadeAnimation(1.6, Container(
                      margin: const EdgeInsets.only(top: 30,),
                      child: const Center(
                        child: CircleAvatar(radius: 90,
                          backgroundImage: AssetImage(
                          'assets/logos/MangaaroApp.ico'
                          ),
                        ),
                      ),
                    )),
                  ),
                Positioned(
                  child: FadeAnimation(1.8, Container(
                    margin: const EdgeInsets.only(top: 250),
                    child: const Center(
                      child: Text("Welcome", style: TextStyle(color: Color.fromARGB(255, 220, 240, 3), fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Trueno'),),
                    ),
                  )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder:
                    (context) => const LoginScreen()));
                },
              child: Column(
              children: <Widget>[
                const SizedBox(height: 50,),
                FadeAnimation(2, Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 155, 159, 238),
                        Color.fromARGB(153, 105, 110, 209),
                      ]
                    )
                  ),
                  child: const Center(
                    child: Text("LOG IN", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Trueno'),),
                  ),
                )),
              ],
            ),
              ),
          ),
            Padding(
            padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder:
                    (context) => const SignUpScreen()));
                },
              child: Column(
              children: <Widget>[
                // const SizedBox(height: 30,),
                FadeAnimation(2, Container(
                    margin: const EdgeInsets.only(top: 0),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 155, 159, 238),
                        Color.fromARGB(153, 105, 110, 209),
                      ]
                    )
                  ),
                  child: const Center(
                    child: Text("SIGN UP", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Trueno'),),
                  ),
                )),
              ],
            ),
              ),
          ),
        ],
      ),
    );
  }
}


























//   Widget _submitButton() {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => const LoginScreen()));
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(vertical: 13),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: const Color(0xffdf8e33).withAlpha(100),
//                   offset: const Offset(2, 4),
//                   blurRadius: 8,
//                   spreadRadius: 2)
//             ],
//             color: const Color(0xfff7892b)),
//         child: const Text(
//           'Login',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _signUpButton() {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(vertical: 13),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           border: Border.all(color: Colors.white, width: 2),
//         ),
//         child: const Text(
//           'Register Now',
//           style: TextStyle(fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _title() {
//     return Column(
//       children: const [
//         SizedBox(
//           height: 70,
//           child: Image(image: AssetImage("assets/images/MangaaroApp.png")),
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     color: Colors.cyan.shade200,
//                     offset: const Offset(2, 4),
//                     blurRadius: 5,
//                     spreadRadius: 2)
//               ],
//               gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xffb9f2ff), Color(0x00ffffff)])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               _title(),
//               const SizedBox(
//                 height: 80,
//               ),
//               _submitButton(),
//               const SizedBox(
//                 height: 20,
//               ),
//               _signUpButton(),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
