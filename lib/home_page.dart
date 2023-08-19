import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: const Color(0xFFE653A2),
            onPressed: () {
              Navigator.pushNamed(context, '/text');
            },
            child: const Icon(Icons.message),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            backgroundColor: const Color(0xFFE653A2),
            onPressed: () {
              Navigator.pushNamed(context, '/speech');
            },
            child: const Icon(Icons.mic),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            backgroundColor: const Color(0xFFE653A2),
            onPressed: () {
              Navigator.pushNamed(context, '/camera');
            },
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: false,
        titleSpacing: 25,
        title: const Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'PalanquinDark',
              fontWeight: FontWeight.w400,
              fontSize: 24),
        ),
        backgroundColor: const Color(0xFF3D3D3D),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'assets/image/b.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.75),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: Text(
                            "SMAGLATOR APLICATION",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'PalanquinDark',
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFE653A2),
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
                        const SizedBox(height: 10),
                        const SizedBox(
                          width: 750,
                          height: 110,
                          child: Text(
                            'Push the button camera for Hand Detection Or\nPush the button mic for Speech to Text',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Robotto',
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 115,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE653A2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Tutorial',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
