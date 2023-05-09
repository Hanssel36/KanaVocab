import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanavocab/screens/SetsScreen.dart';
import 'package:kanavocab/utils/colors.dart';
import 'package:kanavocab/services/hive_backup.dart';
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//     );
//   }
// }

const List<String> fonts = <String>['Font 1', 'Font2', 'Font3'];

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backGroundDark,
        appBar: AppBar(
          backgroundColor: backGroundDark,
          title: const Text("Settings"),
        ),
        body: Column(children: [
          MuteBox(),
          Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
            color: Colors.white30,
          ),
          FontSelector(),
          Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
            color: Colors.white30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Back Up",
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await restoreHiveBox('myBox');
                    ref.read(categoriesandsets.notifier).state =
                        db.categoriesandsetsDB;
                  },
                  child: Text("Restore"))
            ],
          )
        ]),
      ),
    );
  }
}

class MuteBox extends StatefulWidget {
  const MuteBox({super.key});

  @override
  State<MuteBox> createState() => _MuteBox();
}

class _MuteBox extends State<MuteBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                style: const TextStyle(color: Colors.white),
                isChecked ? "Muted" : "Not Muted"),
          ],
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        )
      ],
    );
  }
}

class FontSelector extends StatefulWidget {
  const FontSelector({super.key});

  @override
  State<FontSelector> createState() => _FontSelectorState();
}

class _FontSelectorState extends State<FontSelector> {
  String dropdownValue = fonts.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(style: const TextStyle(color: Colors.white), "Font"),
          ],
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_downward,
          ),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: fonts.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
