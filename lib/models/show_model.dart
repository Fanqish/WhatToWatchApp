import 'dart:convert';

class Show {
  int id;
  String title;
  double rate;
  String poster;
  String backdrop;
  String overview;

  Show(
      {this.id,
      this.title,
      this.rate,
      this.poster,
      this.backdrop,
      this.overview});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'rate': rate,
      'poster': poster,
    };
  }

  factory Show.fromMap(Map<String, dynamic> map) {
    return Show(
      id: map['id'],
      title: map['title'],
      rate: map['rate'],
      poster: map['poster'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Show.fromJson(String source) => Show.fromMap(json.decode(source));
}
