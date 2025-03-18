import 'package:movies/infrastructure/models/themoviedb/movie_themoviedb.dart';

class RecommendedMoviesResponse {
    final int page;
    final List<MovieFromMovieDB> results;
    final int totalPages;
    final int totalResults;

    RecommendedMoviesResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory RecommendedMoviesResponse.fromJson(Map<String, dynamic> json) => RecommendedMoviesResponse(
        page: json["page"],
        results: List<MovieFromMovieDB>.from(json["results"].map((x) => MovieFromMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}