library connectivity_listener;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class ConnectionListener {
  // Singleton Setup
  static final ConnectionListener _connectionService =
      ConnectionListener._internal();

  factory ConnectionListener() {
    return _connectionService;
  }

  ConnectionListener._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool offline = false;

  Future<void> init({
    Function? onConnected,
    Function? onReconnected,
    Function? onDisconnected,
  }) async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (result) => _updateConnectionState(
        result,
        onConnected,
        onReconnected,
        onDisconnected,
      ),
    );

    return _updateConnectionState(
        result, onConnected, onReconnected, onDisconnected);
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }

  void _updateConnectionState(
    ConnectivityResult result,
    Function? onConnected,
    Function? onReconnected,
    Function? onDisconnected,
  ) async {
    switch (result) {
      case ConnectivityResult.ethernet:
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        if (!offline) {
          onConnected ?? () => {};
          return;
        }

        onReconnected ?? () => {};
        break;
      default:
        onDisconnected ?? () => {};
        break;
    }
  }
}
