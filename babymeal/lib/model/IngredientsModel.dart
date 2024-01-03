class PostIngredient {
  String? ingredients;

  PostIngredient({this.ingredients});

  PostIngredient.fromJson(Map<String, dynamic> json) {
    ingredients = json['ingredients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredients'] = this.ingredients;
    return data;
  }
}

class PutIngredient {
  int? fridgeId;
  String? ingredients;

  PutIngredient({this.fridgeId, this.ingredients});

  PutIngredient.fromJson(Map<String, dynamic> json) {
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
