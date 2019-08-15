import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/OAuth/device_code_oauth.dart';
import 'package:ninjanga3/repositories/authentication_repository.dart';

import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository repo;

  AuthenticationBloc(this.repo) : assert(repo != null);

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await repo.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        final DeviceCodeOauth code = await repo.authenticate();
        yield AuthenticationCodeReceived(code);
        try {
          var accessToken = await repo.retrieveAccessToken(code);
          await repo.persistToken(accessToken);
          yield AuthenticationAuthenticated();
        } on Exception catch (e) {
          yield AuthenticationFailed(e);
        }
      }
    }
  }
}
