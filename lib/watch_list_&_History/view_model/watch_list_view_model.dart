import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_states.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial());
}