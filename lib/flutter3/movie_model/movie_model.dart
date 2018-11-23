import 'movie_result.dart';

class MovieModel {
  int page;
  int totalResults;
  int totalPages;
  List<MovieResult> results;

  MovieModel({this.page, this.totalResults, this.totalPages, this.results});

  MovieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<MovieResult>();
      json['results'].forEach((v) {
        results.add(new MovieResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
