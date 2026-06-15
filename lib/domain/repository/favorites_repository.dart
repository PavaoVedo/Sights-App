import 'package:sights_app/domain/model/sight.dart';

abstract interface class FavoritesRepository {
  List<Sight> getFavorites();

  bool isFavorite(final int id);

  Future<void> addFavorite(final Sight sight);

  Future<void> removeFavorite(final int id);
}