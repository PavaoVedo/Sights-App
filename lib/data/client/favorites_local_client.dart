import 'package:hive/hive.dart';
import 'package:sights_app/domain/model/sight.dart';

class FavoritesLocalClient {
  static const String boxName = 'favorites';

  Box<Sight> get _box => Hive.box<Sight>(boxName);

  List<Sight> getAll() => _box.values.toList();

  bool isFavorite(final int id) => _box.containsKey(id);

  Future<void> add(final Sight sight) => _box.put(sight.id, sight);

  Future<void> remove(final int id) => _box.delete(id);
}