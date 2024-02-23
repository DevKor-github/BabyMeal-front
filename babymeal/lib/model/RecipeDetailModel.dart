class RecipeDetail {
  String? dietName;
  String? description;
  String? ingredients;
  String? recipe;
  int? time;
  String? difficulty;
  bool? heart;

  RecipeDetail({
    this.dietName,
    this.description,
    this.ingredients,
    this.recipe,
    this.time,
    this.difficulty,
    this.heart
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      dietName: json['dietName'],
      description: json['description'],
      ingredients: json['ingredients'],
      recipe: json['recipe'],
      time: json['time'],
      difficulty: json['difficulty'],
      heart: json['heart']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dietName': dietName,
      'description': description,
      'ingredients': ingredients,
      'recipe': recipe,
      'time': time,
      'difficulty': difficulty,
      'heart': heart
    };
  }

  @override
  String toString() {
    return 'RecipeDetail(dietName: $dietName, description: $description, ingredients: $ingredients, time: $time, difficulty: $difficulty, recipe: $recipe)';
  }
}