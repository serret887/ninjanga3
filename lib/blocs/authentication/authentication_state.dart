import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/device_code_oauth.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const <dynamic>[]]) : super(props);
}

class InitialAuthenticationState extends AuthenticationState {
  @override
  String toString() => 'InitialAuthenticationState';
}

class AuthenticationInitiated extends AuthenticationState {
  @override
  String toString() => "AuthenticationInitiated";
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => "AuthenticationLoading";
}

class AuthenticationCodeReceived extends AuthenticationState {
  final DeviceCodeOauth code;
  AuthenticationCodeReceived(this.code);

  @override
  String toString() => 'AuthenticationCodeReceived Code ${code.toJson()}';
}

class AuthenticationFailed extends AuthenticationState {
  final Exception exception;
  AuthenticationFailed(this.exception);

  @override
  String toString() => 'AuthenticationFailed $exception';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}
