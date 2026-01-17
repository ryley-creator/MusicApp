part of 'favorite_bloc.dart';

class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoriteEvent {}

class DeleteFavorite extends FavoriteEvent {
  final Track track;
  const DeleteFavorite(this.track);

  @override
  List<Object> get props => [track];
}

class AddFavorite extends FavoriteEvent {
  final Track track;
  const AddFavorite(this.track);
}
