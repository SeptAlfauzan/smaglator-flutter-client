import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextListScreen extends StatelessWidget {
  const TextListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Output Speech to Text'),
        backgroundColor: const Color(0xFF3D3D3D),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('testaja')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text('Error retrieving data from Firestore'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No speech text available.'));
          }

          final latestDocument = snapshot.data!.docs[0];
          final latestText = latestDocument['text'];
          final timestamp = latestDocument['timestamp'] as Timestamp;

          final formattedTimestamp = DateTime.fromMicrosecondsSinceEpoch(
                  timestamp.microsecondsSinceEpoch)
              .toString(); // You can format the timestamp as desired

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    latestText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: Text(
                    'Waktu: $formattedTimestamp',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
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
