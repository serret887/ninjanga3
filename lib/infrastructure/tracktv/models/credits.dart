class Credits {
  List<Cast> cast;
  Crew crew;

  Credits({this.cast, this.crew});

  Credits.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = new List<Cast>();
      json['cast'].forEach((v) {
        cast.add(new Cast.fromJson(v));
      });
    }
    crew = json['crew'] != null ? new Crew.fromJson(json['crew']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    if (this.crew != null) {
      data['crew'] = this.crew.toJson();
    }
    return data;
  }
}

class Cast {
  List<String> characters;

  Cast({
    this.characters,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    characters = json['characters']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['characters'] = this.characters;
    return data;
  }
}

class Crew {
  List<Directing> directing;

  Crew({this.directing});

  Crew.fromJson(Map<String, dynamic> json) {
    if (json['directing'] != null) {
      directing = new List<Directing>();
      json['directing'].forEach((v) {
        directing.add(new Directing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directing != null) {
      data['directing'] = this.directing.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Directing {
  List<String> jobs;

  Directing({
    this.jobs,
  });

  Directing.fromJson(Map<String, dynamic> json) {
    jobs = json['jobs']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobs'] = this.jobs;
    return data;
  }
}
