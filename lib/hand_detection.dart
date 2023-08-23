import './service/mqtt.dart';

import 'package:flutter/material.dart';

import 'dart:async';

class HandDetectionScreen extends StatefulWidget {
  const HandDetectionScreen({super.key});

  @override
  State<HandDetectionScreen> createState() => _HandDetectionScreenState();
}

class _HandDetectionScreenState extends State<HandDetectionScreen> {
  String mqttPayload = "";
  bool isConnected = false;
  bool disableButton = false;
  MQTTWrapper mqttBrowserWrapper = MQTTWrapper();

  void _updateMqttValue(String payload) {
    setState(() {
      mqttPayload = payload;
    });
  }

  void _updateConnectedValue(bool value) {
    setState(() {
      isConnected = value;
    });
  }

  Future<void> toggleConnection() async {
    // MQTTClientWrapper newclient = MQTTClientWrapper();
    // newclient.prepareMqttClient();
    // newclient.listened();

    setState(() {
      disableButton = true;
      // simulate waiting establish connection
    });

    if (!isConnected) {
      mqttBrowserWrapper.init(_updateConnectedValue, _updateMqttValue);
    } else {
      mqttBrowserWrapper.close(_updateConnectedValue);
    }

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      disableButton = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // mqttHandler.prepareMqttClient();
    // mqttHandler.listened();
    // mqttBrowserWrapper.init(_updateMqttValue);
  }

  Color buttonColor = const Color(0xFFE653A2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centering vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centering horizontally
          children: [
            Text(isConnected ? "Connected!" : "Not Connected"),
            Text(disableButton
                ? (!isConnected ? "Connecting.." : "Disconnecting..")
                : ""),
            Text(mqttPayload),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              disableButton ? buttonColor.withOpacity(0.5) : buttonColor,
          onPressed: () {
            !disableButton ? toggleConnection() : null;
          },
          child:
              isConnected ? const Icon(Icons.stop) : const Icon(Icons.start)),
    );
  }
}
