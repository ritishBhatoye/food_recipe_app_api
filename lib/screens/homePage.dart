import 'package:flutter/material.dart';
import 'package:food_recipe_app/models/recipe.dart';
import 'package:food_recipe_app/models/recipe_api.dart';
import 'package:food_recipe_app/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes = []; // Initialize _recipes to an empty list
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    List<Recipe>? recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = true;
      _recipes = recipes ?? []; // If recipes is null, assign an empty list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Food Recipe')
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _recipes.isEmpty // Check if _recipes is empty
              ? Center(child: Text('No recipes found'))
              : ListView.builder(
                  itemCount: _recipes.length, // Remove unnecessary null check
                  itemBuilder: (context, index) {
                    return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime,
                      rating: _recipes[index].rating.toString(),
                      thumbnailUrl: _recipes[index].images,
                    );
                  },
                ),
    );
  }
}
