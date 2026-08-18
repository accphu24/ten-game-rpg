import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameConnection {
  WebSocketChannel? _channel;
  final String playerId;
  final void Function(Map<String, dynamic> message) onMessage;

  GameConnection({required this.playerId, required this.onMessage});

  Future<void> connect(String host, int port) async {
    final uri = Uri.parse('ws://$host:$port');
    _channel = WebSocketChannel.connect(uri);
    await _channel!.ready;

    _channel!.sink.add(jsonEncode({'player_id': playerId}));

    _channel!.stream.listen(
      (raw) => onMessage(jsonDecode(raw as String) as Map<String, dynamic>),
      onDone: () => print('Mất kết nối server'),
      onError: (e) => print('Lỗi WebSocket: $e'),
    );
  }

  void sendAction(String target, {int damage = 10}) {
    _channel?.sink.add(jsonEncode({'target': target, 'damage': damage}));
  }

  void dispose() => _channel?.sink.close();
}
