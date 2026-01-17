import 'package:audio_app/imports/imports.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState()) {
    on<AddFavorite>(onAddFavorite);
    on<LoadFavorites>(onLoadFavorites);
    on<DeleteFavorite>(onDeleteFavorite);
  }

  Future<void> onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final tracks = await LocalDB.getFavorites();
    emit(state.copyWith(tracks: tracks, isLoading: false));
  }

  Future<void> onAddFavorite(
    AddFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await LocalDB.addFavorite(event.track);
    final tracks = await LocalDB.getFavorites();
    emit(state.copyWith(tracks: tracks, isLoading: false));
  }

  Future<void> onDeleteFavorite(
    DeleteFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    await LocalDB.removeFromFavorites(event.track.id);
    final updatedTracks = state.tracks
        .where((e) => e.id != event.track.id)
        .toList();
    emit(state.copyWith(tracks: updatedTracks));
  }
}
