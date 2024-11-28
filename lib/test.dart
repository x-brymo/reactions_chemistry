import 'dart:convert';
import 'package:flutter/services.dart'; // For loading the JSON file
import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // For ListEquality

class ReactionForm extends StatefulWidget {
  @override
  _ReactionFormState createState() => _ReactionFormState();
}

class _ReactionFormState extends State<ReactionForm> {
  List<String> reactants = [];
  List<String> products = [];
  String result = '';
  String name = '';
  String description = '';
  List<Map<String, dynamic>> reactionList = [];

  // Function to load reactions from the JSON file
  Future<void> loadReactions() async {
    final String response = await rootBundle.loadString('assets/reactions.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      reactionList = data.map((reaction) => reaction as Map<String, dynamic>).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadReactions(); // Load the reactions when the app starts
  }

  // Function to add reactants or products
  void addReactant(String reactant) {
    if (reactant.isNotEmpty && !reactants.contains(reactant)) {
      setState(() {
        reactants.add(reactant);
      });
    }
  }

  void addProduct(String product) {
    if (product.isNotEmpty && !products.contains(product)) {
      setState(() {
        products.add(product);
      });
    }
  }

  // Function to find matching reaction
  void findReaction() {
    // Normalize reactants and products (case insensitive)
    final reactantsInput = reactants.map((r) => r.toUpperCase()).toList();
    final productsInput = products.map((p) => p.toUpperCase()).toList();

    // Find the matching reaction
    final matchingReaction = reactionList.firstWhere(
      (reaction) {
        // Normalize the reactants and products in the reaction for case insensitivity
        final reactionReactants = List<String>.from(reaction['reactants']!.map((r) => r.toUpperCase()).toList());
        final reactionProducts = List<String>.from(reaction['products']!.map((p) => p.toUpperCase()).toList());

        // Check if the reactants and products match (ignoring order)
        return ListEquality().equals(reactionReactants, reactantsInput) &&
            ListEquality().equals(reactionProducts, productsInput);
      },
      orElse: () => {}, // Return null if no match found
    );

    if (matchingReaction != null) {
      // If we found a match, update the result with the balanced equation, name, and description
      setState(() {
        result = matchingReaction['balancedEquation'] ?? 'Unknown Equation';
        name = matchingReaction['name'] ?? 'Unknown Name';
        description = matchingReaction['description'] ?? 'No Description';
      });
    } else {
      // If no match found, show an error message
      setState(() {
        result = 'No matching reaction found!';
        name = '';
        description = '';
      });
    }
  }

  // TextEditingController to manage input fields
  TextEditingController reactantController = TextEditingController();
  TextEditingController productController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chemical Reactions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Input for Reactants
              TextField(
                controller: reactantController,
                decoration: InputDecoration(
                  labelText: 'Enter Reactant',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      addReactant(reactantController.text);
                      reactantController.clear();
                    },
                  ),
                ),
              ),
              Wrap(
                children: reactants
                    .map((reactant) => Chip(
                          label: Text(reactant),
                          onDeleted: () {
                            setState(() {
                              reactants.remove(reactant);
                            });
                          },
                        ))
                    .toList(),
              ),
          
              // Input for Products
              TextField(
                controller: productController,
                decoration: InputDecoration(
                  labelText: 'Enter Product',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      addProduct(productController.text);
                      productController.clear();
                    },
                  ),
                ),
              ),
              Wrap(
                children: products
                    .map((product) => Chip(
                          label: Text(product),
                          onDeleted: () {
                            setState(() {
                              products.remove(product);
                            });
                          },
                        ))
                    .toList(),
              ),
          
              SizedBox(height: 20),
          
              // Find Reaction Button
              ElevatedButton(
                onPressed: findReaction,
                child: Text('Find Reaction'),
              ),
          
              // Display Results
              SizedBox(height: 20),
              if (name.isNotEmpty)
                Text(
                  'Reaction: $name\n\nDescription: $description\n\nBalanced Equation: $result',
                  textAlign: TextAlign.center,
                ),
              if (result.isEmpty && name.isEmpty && description.isEmpty)
                Text(
                  result,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
