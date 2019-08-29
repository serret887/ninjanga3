import 'package:fluro/fluro.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ninjanga3/blocs/home/home_bloc.dart';
import 'package:ninjanga3/config/constants.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_movies.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_search.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_series.dart';
import 'package:ninjanga3/repositories/movies_repository.dart';
import 'package:sembast/sembast.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'config/database.dart';
import 'config/shared_preferences.dart';
import 'infrastructure/Retriever/tracktv/services/oauth_device.dart';
import 'infrastructure/casting/service_discover.dart';
import 'repositories/authentication_repository.dart';
import 'repositories/search_repository.dart';
import 'repositories/show_repository.dart';
import 'ui/route/routes.dart';

GetIt sl = new GetIt();

void setup() {
// Config
  sl.allowReassignment = true;
  sl.registerSingleton<http.Client>(http.Client());
  sl.registerLazySingleton<Future<Database>>(
      () async => await AppDatabase.instance.database);
  sl.registerSingleton(Preferences());
// end Config

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
  sl.registerSingleton(TracktTvSeriesAPI(sl.get<http.Client>()));

  sl.registerSingleton<MoviesRepository>(MoviesRepository(
      tracktTvMovieClient: sl.get<TracktTvMoviesAPI>(),
      tmdbClient: sl.get<TmdbClient>(),
      authRepo: sl.get<AuthenticationRepository>(),
      preferences: sl.get<Preferences>(),
      db: sl.get<Future<Database>>(),
      storeName: Constants.MOVIES_DB));

  sl.registerSingleton<ShowRepository>(ShowRepository(
      tracktTvSerieClient: sl.get<TracktTvSeriesAPI>(),
      tmdbClient: sl.get<TmdbClient>(),
      authRepo: sl.get<AuthenticationRepository>(),
      preferences: sl.get<Preferences>(),
      db: sl.get<Future<Database>>(),
      storeName: Constants.SERIES_DB));

  sl.registerSingleton<HomeBloc>(HomeBloc(
    sl.get<MoviesRepository>(),
    sl.get<ShowRepository>(),
  ));

// end home
// search
  sl.registerSingleton<TrackTvSearchAPI>(
      TrackTvSearchAPI(sl.get<http.Client>()));
  sl.registerSingleton<SearchRepository>(
      SearchRepository(sl.get<TrackTvSearchAPI>(), sl.get<TmdbClient>()));
  sl.registerSingleton<SearchBloc>(SearchBloc(sl.get<SearchRepository>()));

  // end search
// Routing
  final router = Router();
  Routes.configureRoutes(router);
  sl.registerSingleton<Router>(router);

// end routing

// casting
  sl.registerSingleton<ServiceDiscovery>(ServiceDiscovery());
// end casting
}
