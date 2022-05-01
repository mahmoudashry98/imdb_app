import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_app/layout/cubit/cubit.dart';
import 'package:imdb_app/layout/cubit/states.dart';
import 'package:imdb_app/modules/description_movies/description_movies_screen.dart';
import 'package:imdb_app/shared/component/components.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var trending = AppCubit.get(context).trendingMovies;
        var topRated = AppCubit.get(context).topRatedMovies;
        var upComing = AppCubit.get(context).upComingMovies;
        return ConditionalBuilder(
          condition: trending != null && topRated != null && upComing != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                'IMDB',
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Display Trending Movies
                    Text(
                      'Trending Movies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildListOfTrendingMovies(
                          context,
                          trending: trending,
                          index: index,
                        ),
                        itemCount: trending.length,
                      ),
                    ),
                    //Display Top Rated Movies
                    Text(
                      'Top Rated Movies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildListOfTopRatedMovies(
                          context,
                          topRated: topRated,
                          index: index,
                        ),
                        itemCount: trending.length,
                      ),
                    ),
                    //Display UpComing Movies
                    Text(
                      'Up Coming Movies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildListOfUpComingMovies(
                          context,
                          upComing: upComing,
                          index: index,
                        ),
                        itemCount: upComing.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
          )),
        );
      },
    );
  }

  Widget buildListOfTrendingMovies(
    context, {
    required final List trending,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        //when to click on specific movie display details for this movie
        navigateTo(
          context,
          DescriptionMoviesScreen(
            name: trending[index]['title'],
            bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                trending[index]['backdrop_path'],
            posterUrl: 'https://image.tmdb.org/t/p/w500' +
                trending[index]['poster_path'],
            description: trending[index]['overview'],
            vote: trending[index]['vote_average'].toString(),
            launchOn: trending[index]['release_date'],
          ),
        );
      },
      child: Column(
        children: [
          //check the list of Trending is not empty and if the list is empty display empty Container
          trending[index]['title'] != null
              ? Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      image: DecorationImage(
                          image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500' +
                            trending[index]['poster_path'],
                      ))),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          Text(
            '${trending[index]['title'] != null ? trending[index]['title'] : 'loading'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget buildListOfTopRatedMovies(
    context, {
    required final List topRated,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          DescriptionMoviesScreen(
            name: topRated[index]['title'],
            bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                topRated[index]['backdrop_path'],
            posterUrl: 'https://image.tmdb.org/t/p/w500' +
                topRated[index]['poster_path'],
            description: topRated[index]['overview'],
            vote: topRated[index]['vote_average'].toString(),
            launchOn: topRated[index]['release_date'],
          ),
        );
      },
      child: Column(
        children: [
          topRated[index]['title'] != null
              ? Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      image: DecorationImage(
                          image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500' +
                            topRated[index]['poster_path'],
                      ))),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          Text(
            '${topRated[index]['title'] != null ? topRated[index]['title'] : 'loading'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget buildListOfUpComingMovies(
    context, {
    required final List upComing,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          DescriptionMoviesScreen(
            name: upComing[index]['title'],
            bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                upComing[index]['backdrop_path'],
            posterUrl: 'https://image.tmdb.org/t/p/w500' +
                upComing[index]['poster_path'],
            description: upComing[index]['overview'],
            vote: upComing[index]['vote_average'].toString(),
            launchOn: upComing[index]['release_date'],
          ),
        );
      },
      child: Column(
        children: [
          upComing[index]['title'] != null
              ? Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      image: DecorationImage(
                          image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500' +
                            upComing[index]['poster_path'],
                      ))),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          Text(
            '${upComing[index]['title'] != null ? upComing[index]['title'] : 'loading'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
