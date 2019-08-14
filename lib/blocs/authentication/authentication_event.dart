import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/OAuth/device_code_oauth.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const <dynamic>[]]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class WaitingForCode extends AuthenticationEvent {
  @override
  String toString() => 'Waiting for authentication code ';
}

class RetrieveAccesCode extends AuthenticationEvent {
  final DeviceCodeOauth code;
  RetrieveAccesCode(this.code);

  @override
  String toString() => 'AuthenticationCodeReceived Code ${code.toJson()}';
}

class LoggedIn extends AuthenticationEvent {
  final String accessToken;
  final String refreshToken;
  LoggedIn({@required this.accessToken, @required this.refreshToken})
      : super([accessToken, refreshToken]);

  @override
  String toString() =>
      'LoggedIn { access_token: $accessToken, refres_token: $refreshToken }';
}
