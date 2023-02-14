import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  List<String> filters = ['All', 'Basic', 'Variants', 'Combinations', 'Custom'];
  Set<String> selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backGroundDark,
        appBar: AppBar(
          title: const Text("Selection"),
          leading: IconButton(
            onPressed: () => context.go("/"),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedFilters.contains(filters[index])) {
                            selectedFilters.remove(filters[index]);
                          } else {
                            selectedFilters.add(filters[index]);
                          }
                        });
                      },
                      child: Chip(
                        label: Text(filters[index]),
                        backgroundColor:
                            selectedFilters.contains(filters[index])
                                ? Colors.blue
                                : const Color.fromARGB(255, 224, 224, 224),
                        labelStyle: TextStyle(
                          color: selectedFilters.contains(filters[index])
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
