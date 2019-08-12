import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ninjanga3/blocs/home/home_bloc.dart';
import 'package:ninjanga3/infrastructure/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:ninjanga3/repositories/related_repository.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'infrastructure/tracktv/services/oauth_device.dart';
import 'repositories/authentication_repository.dart';

GetIt sl = new GetIt();

void setup() {
  sl.allowReassignment = true;
  sl.registerSingleton<http.Client>(http.Client());

// authentication
  sl.registerSingleton<OauthDevice>(OauthDevice(sl.get<http.Client>()));
  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  sl.registerSingleton<AuthenticationRepository>(AuthenticationRepository(
      sl.get<OauthDevice>(), sl.get<FlutterSecureStorage>()));
  sl.registerSingleton<AuthenticationBloc>(
      AuthenticationBloc(sl.get<AuthenticationRepository>()));
// end authentication

// home
  sl.registerSingleton(TmdbClient(sl.get<http.Client>()));
  sl.registerSingleton(TracktTvMoviesAPI(sl.get<http.Client>()));
  sl.registerSingleton<MoviesRepository>(
      MoviesRepository(sl.get<TracktTvMoviesAPI>(), sl.get<TmdbClient>(),
          sl.get<AuthenticationRepository>()));
  sl.registerSingleton<HomeBloc>(HomeBloc(sl.get<MoviesRepository>()));

// end home
// related
  sl.registerSingleton<RelatedRepository>(
      RelatedRepository(sl.get<TracktTvMoviesAPI>(), sl.get<TmdbClient>()));
//end related
}
