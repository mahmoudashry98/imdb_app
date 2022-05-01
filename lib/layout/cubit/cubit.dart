import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_app/layout/cubit/states.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List trendingMovies = [];
  List topRatedMovies = [];
  List upComingMovies = [];


  void getMovies() async {
    emit(AppLoadingGetMoviesState());
    TMDB tmdbWithCustomlogs = TMDB(
      ApiKeys(apikey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map trendingResult = await tmdbWithCustomlogs.v3.movies.getPopular();
    Map topRatedResult = await tmdbWithCustomlogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomlogs.v3.tv.getPopular();
    Map upComing = await tmdbWithCustomlogs.v3.movies.getUpcoming();
    trendingMovies = trendingResult['results'];
    topRatedMovies = topRatedResult['results'];
    upComingMovies =upComing['results'];
    emit(AppSuccessGetMoviesState());
  }
}
