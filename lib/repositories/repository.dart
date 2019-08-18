import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/models/db/baseDb.dart';
import 'package:sembast/sembast.dart';

import 'authentication_repository.dart';

class Repository<T extends BaseDb> {
  final AuthenticationRepository authRepo;
  final Preferences preferences;
  final Future<Database> db;
  final String storeName;
  StoreRef<String, Map<String, dynamic>> store;

  Repository(this.authRepo, this.preferences, this.db, this.storeName) {
    store = stringMapStoreFactory.store(storeName);
  }

  Future<bool> needsRefresh() async {
    var lastRefresh = await preferences.getLastRefresh(storeName);
    return DateTime.now().difference(lastRefresh) > Duration(days: 1);
  }

  Future setRefresh() async {
    await preferences.setLastRefresh(storeName);
  }

  Future insert(T movie) async =>
      await store.record(movie.ids.slug).add(await db, movie.toJson());
  Future update(T movie) async {
    var c = await db;
    var a = await store.delete(await db,
        finder: Finder(filter: Filter.byKey(movie.ids.slug)));
    var w = await store.record(movie.ids.slug).get(c);
    await store
        .record(movie.ids.slug)
        .put(await db, movie.toJson(), merge: true);
    var w1 = await store.record(movie.ids.slug).get(c);
    print("helloasd");
  }

  Future insertAll(List<T> movies) async {
    await (await db).transaction((txn) async {
      var futures = movies.map((mov) async => await store
          .record(mov.ids.slug)
          .add(txn, mov.toJson())
          .catchError((error) => print(error)));
      await Future.wait(futures);
    });
  }
}
