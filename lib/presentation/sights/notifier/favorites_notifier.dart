import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sights_app/di.dart';
import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/domain/usecase/get_favorites_use_case.dart';
import 'package:sights_app/domain/usecase/toggle_favorite_use_case.dart';

class FavoritesNotifier extends Notifier<List<Sight>> {
  late GetFavoritesUseCase _getFavoritesUseCase;
  late ToggleFavoriteUseCase _toggleFavoriteUseCase;

  @override
  List<Sight> build() {
    _getFavoritesUseCase = ref.watch(getFavoritesUseCaseProvider);
    _toggleFavoriteUseCase = ref.watch(toggleFavoriteUseCaseProvider);
    return _getFavoritesUseCase();
  }

  bool isFavorite(final int id) => state.any((sight) => sight.id == id);

  Future<void> toggle(final Sight sight) async {
    await _toggleFavoriteUseCase(sight);
    state = _getFavoritesUseCase();
  }
}