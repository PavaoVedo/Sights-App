import 'package:sights_app/data/client/favorites_local_client.dart';
import 'package:sights_app/data/client/firebase_auth_client.dart';
import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/domain/repository/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalClient localClient;
  final FirebaseAuthClient authClient;

  FavoritesRepositoryImpl(this.localClient, this.authClient);

  String get _uid => authClient.getCurrentUser()?.uid ?? 'guest';

  @override
  List<Sight> getFavorites() => localClient.getAll(_uid);

  @override
  bool isFavorite(int id) => localClient.isFavorite(_uid, id);

  @override
  Future<void> addFavorite(Sight sight) => localClient.add(_uid, sight);

  @override
  Future<void> removeFavorite(int id) => localClient.remove(_uid, id);
}