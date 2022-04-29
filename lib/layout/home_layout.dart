import 'package:flutter/material.dart';
import 'package:imdb_app/layout/cubit/cubit.dart';
import 'package:imdb_app/modules/description_movies/description_movies_screen.dart';
import 'package:imdb_app/shared/component/components.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trending = AppCubit.get(context).trendingMovies;
    var topRated = AppCubit.get(context).topRatedMovies;
    var tv = AppCubit.get(context).tv;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IMDB',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  itemBuilder: (context, index) => buildListOfTrendingMovies(
                    trending: trending,
                    index: index,
                  ),
                  itemCount: trending.length,
                ),
              ),
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
                  itemBuilder: (context, index) => buildListOfTopRatedMovies(
                    topRated: topRated,
                    index: index,
                  ),
                  itemCount: trending.length,
                ),
              ),
              Text(
                'Popular Tv Shows Movies',
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
                  itemBuilder: (context, index) => buildListOfTvShows(
                    tv: tv,
                    index: index,
                  ),
                  itemCount: trending.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListOfTrendingMovies(
      {required final List trending, required int index, context}) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          DescriptionMoviesScreen(
            name: trending[index]['title'],
            bannerUrl: 'https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path'],
            posterUrl: 'https://image.tmdb.org/t/p/w500'+trending[index]['poster_path'],
            description: trending[index]['overview'],
            vote: trending[index]['vote_average'],
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                image: DecorationImage(
                    image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500' +
                      trending[index]['poster_path'],
                ))),
          ),
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
      {required final List topRated, required int index}) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              image: DecorationImage(
                  image: NetworkImage(
                'https://image.tmdb.org/t/p/w500' +
                    topRated[index]['poster_path'],
              ))),
        ),
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
    );
  }

  Widget buildListOfTvShows({required final List tv, required int index}) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              image: DecorationImage(
                  image: NetworkImage(
                'https://image.tmdb.org/t/p/w500' + tv[index]['poster_path'],
              ))),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${tv[index]["original_name"] != null ? tv[index]["original_name"] : 'loading'}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
