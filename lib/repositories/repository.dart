import 'package:ninjanga3/config/shared_preferences.dart';
import 'package:ninjanga3/models/db/baseDb.dart';
import 'package:sembast/sembast.dart';

import 'authentication_repository.dart';

class Repository<T extends BaseDb> {
  final AuthenticationRepository authRepo;
  final Preferences preferences;
  final Future<Database> db;

  StoreRef<String, Map<String, dynamic>> _store;

  Repository(this.authRepo, this.preferences, this.db, storeName) {
    _store = stringMapStoreFactory.store(storeName);
  }

  Future<bool> _needsRefresh() async {
    var lastRefresh = await preferences.getLastRefresh();
    return DateTime.now().difference(lastRefresh) > Duration(days: 1);
  }

  Future insert(T movie) async =>
      await _store.record(movie.ids.slug).add(await db, movie.toJson());

  Future insertAll(List<T> movies) async {
    await (await db).transaction((txn) async {
      var futures = movies.map((mov) async => await _store
          .record(mov.ids.slug)
          .add(txn, mov.toJson())
          .catchError((error) => print(error)));
      await Future.wait(futures);
    });
  }

  Future<List<T>> read([Finder finder]) async {
    var data = await _store.find(await db, finder: finder);
    return data.map((mov) => mov.fromJson(mov.value)).toList();
  }
}
