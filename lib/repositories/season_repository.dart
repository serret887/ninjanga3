import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/infrastructure/Retriever/tmdb/tmdb_client.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/services/trackt_tv_series.dart';
import 'package:ninjanga3/models/db/season_db.dart';
import 'package:ninjanga3/repositories/common.dart';
import 'package:sembast/sembast.dart';

import 'authentication_repository.dart';

class SeasonRepository {
  final TracktTvSeriesAPI tracktTvSerieClient;
  final TmdbClient tmdbClient;
  final AuthenticationRepository authRepo;
  final Preferences preferences;
  final Future<Database> db;
  final store = stringMapStoreFactory.store("seasons");

  SeasonRepository(
      {this.authRepo,
      this.preferences,
      this.db,
      this.tracktTvSerieClient,
      this.tmdbClient});

  String _keyGen(String slug, int number) => '$slug-$number';

  Future<SeasonDb> getSeasonDetails(String slug, int number) async {
    var seasonDb = await store.record(_keyGen(slug, number)).get(await db);

    if (seasonDb != null) return SeasonDb.fromJson(seasonDb);

    var season = await _retrieveSingleSeason(slug, number);

    await insert(season);
    return season;
  }

  Future<SeasonDb> _retrieveSingleSeason(String slug, int number) async {
    var seasonTrackt = await tracktTvSerieClient.getSingleSeasonsForShow(
        slug: slug, number: number);
    return await Common.completeSeasonImagesFromTrackt(
      seasonTrackt,
      tmdbClient,
    );
  }

  Future insert(SeasonDb season) async => await store
      .record(_keyGen(season.ids.slug, season.number))
      .add(await db, season.toJson());
}
