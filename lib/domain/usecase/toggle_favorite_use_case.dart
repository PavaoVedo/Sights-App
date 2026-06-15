import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/domain/repository/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(final Sight sight) async {
    if (repository.isFavorite(sight.id)) {
      await repository.removeFavorite(sight.id);
    } else {
      await repository.addFavorite(sight);
    }
  }
}