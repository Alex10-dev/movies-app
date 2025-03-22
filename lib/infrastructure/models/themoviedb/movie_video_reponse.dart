class MovieVideoResponse {
    final int id;
    final List<VideoInformation> results;

    MovieVideoResponse({
        required this.id,
        required this.results,
    });

    factory MovieVideoResponse.fromJson(Map<String, dynamic> json) => MovieVideoResponse(
        id: json["id"],
        results: json["results"] != null ? List<VideoInformation>.from(json["results"].map((x) => VideoInformation.fromJson(x))) : [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class VideoInformation {
    final String iso6391;
    final String iso31661;
    final String name;
    final String key;
    final String site;
    final int size;
    final String type;
    final bool official;
    final DateTime publishedAt;
    final String id;

    VideoInformation({
        required this.iso6391,
        required this.iso31661,
        required this.name,
        required this.key,
        required this.site,
        required this.size,
        required this.type,
        required this.official,
        required this.publishedAt,
        required this.id,
    });

    factory VideoInformation.fromJson(Map<String, dynamic> json) => VideoInformation(
        iso6391: json["iso_639_1"] ?? '',
        iso31661: json["iso_3166_1"] ?? '',
        name: json["name"] ?? '',
        key: json["key"] ?? '',
        site: json["site"] ?? '',
        size: json["size"] ?? '',
        type: json["type"] ?? '',
        official: json["official"] ?? '',
        publishedAt: json["published_at"] != null ? DateTime.parse(json["published_at"]) : DateTime.now(),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": "${publishedAt.year.toString().padLeft(4, '0')}-${publishedAt.month.toString().padLeft(2, '0')}-${publishedAt.day.toString().padLeft(2, '0')}",
        "id": id,
    };
}
