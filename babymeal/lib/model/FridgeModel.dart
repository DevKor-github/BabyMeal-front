class GetFridge {
  int? fridgeId;
  String? ingredients;

  GetFridge({this.fridgeId, this.ingredients});

  GetFridge.fromJson(Map<String, dynamic> json) {
    fridgeId = json['fridgeId'];
    ingredients = json['ingredients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fridgeId'] = this.fridgeId;
    data['ingredients'] = this.ingredients;
    return data;
  }
}