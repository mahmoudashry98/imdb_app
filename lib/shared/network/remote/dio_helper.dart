import 'package:dio/dio.dart';

const String apikey = '4c6110771722a2bbd2a2d428cead0701';
const String readAccessToken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YzYxMTA3NzE3MjJhMmJiZDJhMmQ0MjhjZWFkMDcwMSIsInN1YiI6IjYyNjk0NTg0Mzg3NjUxMDE2NTgwZTkzYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QYDlCF_8vNK1MrlkhvwsR3Wj8j7zW7t2ftdtPch_QXo';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/movie/popular?$apikey',
        receiveDataWhenStatusError: true,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );
  }
}
