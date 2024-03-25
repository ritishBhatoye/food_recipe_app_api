import 'dart:convert';
import 'package:food_recipe_app/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
//   const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');

// req.query({
// 	limit: '24',
// 	start: '0'
// });

// req.headers({
  // 'X-RapidAPI-Key': '8088c4dd66msh6c415d853cc17e4p1ba816jsn0065ee20f5db',
  // 'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
// });

// req.end(function (res) {
// 	if (res.error) throw new Error(res.error);

// 	console.log(res.body);
// });
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.http('yummly2.p.rapidapi.com', "/feeds/list",
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': '8088c4dd66msh6c415d853cc17e4p1ba816jsn0065ee20f5db',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
      "useQueryString": "true"
    });
    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }
    return Recipe.recipesFromSnapshot(_temp);
  }
}
