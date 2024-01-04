import 'package:mqtt_client/mqtt_client.dart';

abstract interface class IMqttService {
  Future<void> connect();
  Future<void> disconnect();
  Future<void> publish(String topic, String message);
  Future<void> subscribe(String topic);
  Stream<List<MqttReceivedMessage<MqttMessage>>> get dataReceived;
}
