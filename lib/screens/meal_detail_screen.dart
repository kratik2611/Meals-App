import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool _showIngredients = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    final mealImage = Image.network(
      selectedMeal.imageUrl,
      fit: BoxFit.cover,
    );

    final mealAppBar = AppBar(
      title: Text('${selectedMeal.title}'),
    );

    final stepsList = Column(
      children: selectedMeal.steps
          .map((meal) => Card(
                child: ListTile(
                  leading: Icon(
                    Icons.double_arrow_sharp,
                  ),
                  title: Text(meal),
                ),
              ))
          .toList(),
    );

    return Scaffold(
      appBar: mealAppBar,
      body: SingleChildScrollView(
        child: Container(
          // height: 500,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Container(
                // height: (MediaQuery.of(context).size.height -
                //         MediaQuery.of(context).padding.top -
                //         mealAppBar.preferredSize.height) *
                //     0.45,
                child: mealImage,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.list_sharp),
                        Text(
                          ' Ingredients',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),
                    Switch(
                      value: _showIngredients,
                      onChanged: (val) {
                        setState(() {
                          _showIngredients = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_showIngredients)
                Container(
                  padding: const EdgeInsets.all(5),
                  // height: 100,
                  width: 250,
                  child: Column(
                    children: selectedMeal.ingredients.map((meal) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.assignment_turned_in_outlined,
                              size: 18,
                            ),
                            Text(meal),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(width: 2, color: Colors.grey),
                    ),
                  ),
                ),
              Divider(
                thickness: 1,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Steps',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Container(
                child: stepsList,
                width: 350,
              ),
              // SingleChildScrollView(
              //   child: Container(
              //     padding: const EdgeInsets.all(5),
              //     height: 90,
              //     width: 250,
              //     child: stepsList,
              //     decoration: BoxDecoration(
              //       border: Border.symmetric(
              //         horizontal: BorderSide(width: 2, color: Colors.grey),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          widget.isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          widget.toggleFavorite(mealId);
        },
      ),
    );
  }
}
