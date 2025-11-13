// import 'dart:nativewrappers/_internal/vm/bin/common_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ add this
import 'package:band_names/services/socket_service.dart'; // ✅ add this

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Center(child: Text('Socket status: ${socketService.state}')),
    );
  }
}
