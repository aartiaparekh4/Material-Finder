import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebrtcScreen extends StatefulWidget {
  const WebrtcScreen({super.key});

  @override
  State<WebrtcScreen> createState() => _WebrtcScreenState();
}

class _WebrtcScreenState extends State<WebrtcScreen> {
  final _localVideoRenderer = RTCVideoRenderer();

  void initRenderers() async {
    await _localVideoRenderer.initialize();
  }

  @override
  void initState() {
    initRenderers();
    _getUserMedia();
    super.initState();
  }

  @override
  void dispose() async {
    await _localVideoRenderer.dispose();
    super.dispose();
  }

  _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };

    MediaStream stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localVideoRenderer.srcObject = stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Stack(
        children: [
          Positioned(top: 0.0, right: 0.0, left: 0.0, bottom: 0.0, child: RTCVideoView(_localVideoRenderer)),
        ],
      ),
    );
  }
}
