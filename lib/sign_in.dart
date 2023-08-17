import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  final void Function()? onPressed;
  const SignIn({super.key, required this.onPressed});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool _obscureText = true;

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No user found for that email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wrong password provided for that user."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Row(
              children: <Widget>[
                // Left side of the screen
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // Background image
                      Image.asset(
                        'assets/Difabel.png',
                        fit: BoxFit.cover,
                      ),
                      // Semi-transparent container with text
                      Container(
                        padding: const EdgeInsets.only(left: 75),
                        color: const Color(0xFFE11E87).withOpacity(0.75),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  child: Text(
                                    'Dont\nhave account?',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 42,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: widget.onPressed,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .white, // Set button background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'Daftar',
                                      style: TextStyle(
                                          color: Color(0xFFE11E87),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
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
                // Right side of the screen
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 75, left: 75, top: 20, bottom: 60),
                          child: OverflowBar(
                            overflowSpacing: 15,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'ASSISTIVE DEVICE APLICATION \n',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 46,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFE11E87),
                                    shadows: [
                                      Shadow(
                                        color: Colors.white.withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(1, 2),
                                      ),
                                    ],
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text:
                                          'facilitate communication between the deaf and the community',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 26,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 3),
                              const SizedBox(
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: _email,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Email is Empty';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Example@gmail.com',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0,
                                        right: 15), // Adjust padding as needed
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: _password,
                                obscureText: _obscureText,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Password is Empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Masukkan Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0,
                                        right: 15), // Adjust padding as needed
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      signInWithEmailAndPassword();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xFFE11E87),
                                          ),
                                        )
                                      : const Text(
                                          'Masuk',
                                          style: TextStyle(
                                              color: Color(0xFFE11E87),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
