import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum SocketState { disconnected, connecting, connected }

class SocketService with ChangeNotifier {
  SocketState _state = SocketState.disconnected;

  SocketService() {
    _initConfig(); // 👈 called here
  }

  SocketState get state => _state;

  void _initConfig() {
    _state = SocketState.connecting;

    IO.Socket socket = IO.io('http://localhost:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('connect');

      _state = SocketState.connected;
      notifyListeners();
    });

    socket.on('event', (data) => print(data));

    socket.onDisconnect((_) {
      print('disconnect');
      _state = SocketState.disconnected;
      notifyListeners();
    });

    socket.on('fromServer', (data) => print(data));

    socket.on("nuevo-mensaje", (payload) {
      print("nuevo-mensaje: $payload");
    });
  }
}
