class GetFridge {
  int? fridgeId;
  String? ingredients;
  bool? active;
  String? emoticon;
  GetFridge({this.fridgeId, this.ingredients, this.active, this.emoticon});

  GetFridge.fromJson(Map<String, dynamic> json) {
    fridgeId = json['fridgeId'];
    ingredients = json['ingredients'];
    active = json['active'];
    emoticon = json['emoticon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fridgeId'] = this.fridgeId;
    data['ingredients'] = this.ingredients;
    data['active'] = this.active;
    data['emoticon'] = this.emoticon;
    return data;
  }
}

class postIngredient{
  String? ingrdient;

}