class FridgeContent {
  final String ingredients;
  final String emoticon;

  FridgeContent({required this.ingredients, required this.emoticon});

  factory FridgeContent.fromJson(Map<String, dynamic> json) {
    return FridgeContent(
      ingredients: json['ingredients'],
      emoticon: json['emoticon'] ?? '',
    );
  }
}
