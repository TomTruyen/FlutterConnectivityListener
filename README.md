# Connectivity Listener

Connectivity Listener is a simple package that can be used to listen for changes in the connectivity.

## Installation

```yaml
dependencies:
  flutter:
    sdk: flutter
  connectivity_listener: ^0.0.1
```

## Usage

```dart
import 'package:connectivity_listener/connectivity_listener.dart';
```

```dart
// The listener
final _connectionListener = ConnectionListener();

// Initialize the listener
@override
void initState() {
    super.initState();
    _connectionListener.init(
        onConnected: () => print("CONNECTED"),
        onReconnected: () => print("RECONNECTED"),
        onDisconnected: () => print("DISCONNECTED"),
    );
}

// Dipose the listener
@override
void dispose() {
    _connectionListener.dispose();
    super.dispose();
}
```

## Methods

| Method      | Description                                                                                                                                                                    |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `init()`    | `Creates the listener. Has 3 parameters: onConnected, onReconnected, onDisconnected. These can be used to perform a function when the specific connection status is detected.` |
| `dispose()` | `Should be called on dipose. This cleans up the active listener and cancels all subscriptions`                                                                                 |

## Demo

<img src="https://raw.githubusercontent.com/TomTruyen/FlutterConnectivityListener/main/assets/example.gif" width="200" height="429"/>
