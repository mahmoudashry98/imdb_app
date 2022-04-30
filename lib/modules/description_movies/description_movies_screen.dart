import 'package:flutter/material.dart';

class DescriptionMoviesScreen extends StatelessWidget {
  final String? name;
  final String? description;
  final String? bannerUrl;
  final String? posterUrl;
  final String? vote;
  final String? launchOn;

  const DescriptionMoviesScreen(
      {Key? key,
      this.name,
      this.description,
      this.bannerUrl,
      this.posterUrl,
      this.vote,
      this.launchOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      bannerUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      Text(
                        ' Average Rating - ' + vote!,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '${name != null ? name : 'Not Loading'}',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Releasing On - ' + launchOn!,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 200,
                width: 100,
                child: Image.network(posterUrl!),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${description!}',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
