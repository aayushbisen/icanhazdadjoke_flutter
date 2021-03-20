class Joke {
  String id;
  String joke;
  int status;

  Joke({this.id, this.joke, this.status});

  Joke.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joke = json['joke'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['joke'] = this.joke;
    data['status'] = this.status;
    return data;
  }
}
