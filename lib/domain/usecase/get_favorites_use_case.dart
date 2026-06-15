import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/domain/repository/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  List<Sight> call() => repository.getFavorites();
}