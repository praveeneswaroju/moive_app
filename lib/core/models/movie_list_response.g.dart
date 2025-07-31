// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieListResponseAdapter extends TypeAdapter<MovieListResponse> {
  @override
  final int typeId = 0;

  @override
  MovieListResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieListResponse(results: (fields[0] as List?)?.cast<Results>());
  }

  @override
  void write(BinaryWriter writer, MovieListResponse obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieListResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultsAdapter extends TypeAdapter<Results> {
  @override
  final int typeId = 1;

  @override
  Results read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Results(
      id: fields[0] as int?,
      title: fields[1] as String?,
      posterPath: fields[2] as String?,
      overview: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Results obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.overview);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) =>
    MovieListResponse(
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{'results': instance.results};

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  posterPath: json['poster_path'] as String?,
  overview: json['overview'] as String?,
);

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'poster_path': instance.posterPath,
  'overview': instance.overview,
};
