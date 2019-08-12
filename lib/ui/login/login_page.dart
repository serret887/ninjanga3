import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_bloc.dart';
import 'package:ninjanga3/blocs/authentication/authentication_state.dart';
import 'package:ninjanga3/blocs/authentication/bloc.dart';
import 'package:ninjanga3/ui/login/alert_login.dart';
import 'package:ninjanga3/ui/login/login_component.dart';

import '../../service_locator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _getLoginStateWidget(AuthenticationState state) {
    if (state is AuthenticationCodeReceived) {
      return LoginComponent(state.code);
    } else if (state is AuthenticationFailed) {
      return AlertLogin(
          dispatch: () => sl.get<AuthenticationBloc>().dispatch(AppStarted()));
    } else if (state is InitialAuthenticationState) {
      return Container();
    } else {
      return AlertLogin(
        dispatch: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: sl.get<AuthenticationBloc>(),
      builder: (context, state) {
        return _getLoginStateWidget(state);
      },
    );
  }
}
