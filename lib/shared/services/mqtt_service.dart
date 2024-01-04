// ignore_for_file: avoid_print

import 'package:mqtt_app/shared/services/i_mqtt_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final class MqttService implements IMqttService {
  late MqttServerClient client;
  @override
  Future<void> connect() async {
    client = MqttServerClient.withPort('test.mosquitto.org', 'ZxH5TiECxV', 1883)
      ..logging(on: true)
      ..onConnected = _onConnected
      ..onDisconnected = _onDisconnected
      ..onUnsubscribed = _onUnsubscribed
      ..onSubscribed = _onSubscribed
      ..pongCallback = _pong
      ..keepAlivePeriod = 60
      ..logging(on: true)
      ..setProtocolV311();
    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('MQTT_LOGS::Mosquitto client connecting....');

    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT_LOGS::Mosquitto client connected');
    } else {
      print(
          'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return;
    }
  }

  @override
  Future<void> disconnect() async {
    client.disconnect();
  }

  @override
  Future<void> publish(String topic, String message) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
    }
  }

  @override
   Future<void>  subscribe(String topic) async{
    client.subscribe(topic, MqttQos.atMostOnce);
  }

  @override
  Stream<List<MqttReceivedMessage<MqttMessage>>> get dataReceived =>
      client.updates!;
      

  void _onConnected() {
    print('MQTT_LOGS:: Connected');
  }

  void _onDisconnected() {
    print('MQTT_LOGS:: Disconnected');
  }

  void _onSubscribed(String topic) {
    print('MQTT_LOGS:: Subscribed topic: $topic');
  }

  void _onSubscribeFail(String topic) {
    print('MQTT_LOGS:: Failed to subscribe $topic');
  }

  void _onUnsubscribed(String? topic) {
    print('MQTT_LOGS:: Unsubscribed topic: $topic');
  }

  void _pong() {
    print('MQTT_LOGS:: Ping response client callback invoked');
  }
}
