import 'package:sights_app/data/client/favorites_local_client.dart';
import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/domain/repository/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalClient localClient;

  FavoritesRepositoryImpl(this.localClient);

  @override
  List<Sight> getFavorites() => localClient.getAll();

  @override
  bool isFavorite(int id) => localClient.isFavorite(id);

  @override
  Future<void> addFavorite(Sight sight) => localClient.add(sight);

  @override
  Future<void> removeFavorite(int id) => localClient.remove(id);
}