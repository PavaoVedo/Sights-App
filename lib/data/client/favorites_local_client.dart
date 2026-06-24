import 'package:hive/hive.dart';
import 'package:sights_app/domain/model/sight.dart';

class FavoritesLocalClient {
  static const String boxName = 'favorites';

  Box<Sight> get _box => Hive.box<Sight>(boxName);

  String _key(String uid, int sightId) => '$uid::$sightId';

  List<Sight> getAll(String uid) {
    final prefix = '$uid::';
    return _box.keys
        .where((k) => k is String && k.startsWith(prefix))
        .map((k) => _box.get(k))
        .whereType<Sight>()
        .toList();
  }

  bool isFavorite(String uid, int sightId) => _box.containsKey(_key(uid, sightId));

  Future<void> add(String uid, Sight sight) => _box.put(_key(uid, sight.id), sight);

  Future<void> remove(String uid, int sightId) => _box.delete(_key(uid, sightId));
}