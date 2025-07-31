import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_list_response.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class MovieListResponse {
  @HiveField(0)
  List<Results>? results;

  MovieListResponse({this.results});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable()
class Results {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  @JsonKey(name: 'poster_path')
  String? posterPath;

  @HiveField(3)
  String? overview;

  Results({this.id, this.title, this.posterPath, this.overview});

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
