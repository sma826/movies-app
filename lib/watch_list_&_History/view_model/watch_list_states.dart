abstract class WatchListState {}

class WatchListInitial extends WatchListState {}

class WatchListLoading extends WatchListState {}

class WatchListActionSuccess extends WatchListState {
	final String message;
	WatchListActionSuccess(this.message);
}

class WatchListError extends WatchListState {
	final String message;
	WatchListError(this.message);
}

class WatchListIsFavoriteState extends WatchListState {
	final bool isFavorite;
	WatchListIsFavoriteState(this.isFavorite);
}

class WatchListLoaded extends WatchListState {
	final List<dynamic> favorites;
	WatchListLoaded(this.favorites);
}