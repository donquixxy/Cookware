class Recipes {
  String id;
  String name;
  String description;
  List listIngredients;
  String cookTime;
  String recipeBy;
  String imageUrl;
  String uidCreator;

  Recipes(
      {required this.id,
      required this.name,
      required this.description,
      required this.listIngredients,
      required this.cookTime,
      required this.recipeBy,
      required this.imageUrl,
      required this.uidCreator});

  factory Recipes.fromJson(Map<String, dynamic> fromJson) {
    return Recipes(
        id: fromJson['id'],
        name: fromJson['namaResep'],
        description: fromJson['description'],
        cookTime: fromJson['cookTime'],
        imageUrl: fromJson['imageUrl'],
        recipeBy: fromJson['recipeBy'],
        uidCreator: fromJson['uidCreator'],
        listIngredients: fromJson['listIngredients']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'namaResep': name,
        'description': description,
        'cookTime': cookTime,
        'imageUrl': imageUrl,
        'recipeBy': recipeBy,
        'uidCreator': uidCreator,
        'listIngredients': listIngredients
      };
}
