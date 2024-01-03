class PostDiet {
  int? postId;
  String? updateDate;
  int? comments;
  int? likes;
  String? title;
  String? body;
  List<String>? photos;
  String? category;
  int? scrap;
  String? type;

  PostDiet(
      {this.postId,
      this.updateDate,
      this.comments,
      this.likes,
      this.title,
      this.body,
      this.photos,
      this.category,
      this.scrap,
      this.type});

  PostDiet.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    updateDate = json['updateDate'];
    comments = json['comments'];
    likes = json['likes'];
    title = json['title'];
    body = json['body'];
    photos = json['photos'].cast<String>();
    category = json['category'];
    scrap = json['scrap'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['updateDate'] = this.updateDate;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['title'] = this.title;
    data['body'] = this.body;
    data['photos'] = this.photos;
    data['category'] = this.category;
    data['scrap'] = this.scrap;
    data['type'] = this.type;
    return data;
  }
}
