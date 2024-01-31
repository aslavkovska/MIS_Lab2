import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'MIS-lab2',
      home: MyApp(),
    ),
  );
}

class Clothes {
  String type;
  String color;
  String gender;

  Clothes({required this.type, required this.color, required this.gender});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Clothes> clothesList = [];
  String currentTypeAdd = 'Jacket';
  String currentColorAdd = 'Black';
  String currentGenderAdd = 'Woman\'s';
  String currentTypeEdit = '';
  String currentColorEdit = '';
  String currentGenderEdit = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothes List',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Anastasija\'s Clothes List',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.lightGreen),
          ),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => addClothesDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Add Clothes',
                  style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 20),
            const Text('All Clothes:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: clothesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${clothesList[index].gender} ${clothesList[index].color} ${clothesList[index].type}',
                        style:
                        const TextStyle(color: Colors.blue, fontSize: 18)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => editClothesDialog(index),
                          color: Colors.green,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteClothes(index),
                          color: Colors.green,
                        ),
                      ],
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

  Widget typeDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currentTypeAdd) {
            currentTypeAdd = value!;
          } else if (currentValue == currentTypeEdit) {
            currentTypeEdit = value!;
          }
        });
      },
      items: ['Jacket', 'Coat', 'Blazer', 'Sweatshirt', 'T-shirt', 'Trousers', 'Jeans', 'Shorts']
          .map<DropdownMenuItem<String>>((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Type', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  Widget colorDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currentColorAdd) {
            currentColorAdd = value!;
          } else if (currentValue == currentColorEdit) {
            currentColorEdit = value!;
          }
        });
      },
      items: ['Black', 'Blue', 'Brown', 'Green', 'Beige', 'Grey', 'Red', 'White', 'Yellow']
          .map<DropdownMenuItem<String>>((String color) {
        return DropdownMenuItem<String>(
          value: color,
          child: Text(color),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Color', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  Widget genderDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currentGenderAdd) {
            currentGenderAdd = value!;
          } else if (currentValue == currentGenderEdit) {
            currentGenderEdit = value!;
          }
        });
      },
      items: ['Woman\'s', 'Man\'s']
          .map<DropdownMenuItem<String>>((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Gender', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  void addClothesDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Clothes'),
          content: Column(
            children: [
              typeDropdown(currentTypeAdd),
              colorDropdown(currentColorAdd),
              genderDropdown(currentGenderAdd),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
              ),
              onPressed: () {
                addClothes();
                Navigator.pop(context);
              },
              child: const Text('Add',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void addClothes() {
    if (currentTypeAdd.isNotEmpty && currentColorAdd.isNotEmpty && currentGenderAdd.isNotEmpty) {
      setState(() {
        clothesList.add(Clothes(type: currentTypeAdd, color: currentColorAdd, gender: currentGenderAdd));
      });
    }
  }

  void editClothesDialog(int index) {
    currentTypeEdit = clothesList[index].type;
    currentColorEdit = clothesList[index].color;
    currentGenderEdit = clothesList[index].gender;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Clothes'),
          content: Column(
            children: [
              typeDropdown(currentTypeEdit),
              colorDropdown(currentColorEdit),
              genderDropdown(currentGenderEdit),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
              onPressed: () {
                editClothes(index);
                Navigator.pop(context);
              },
              child: const Text('Save',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void editClothes(int index) {
    if (currentTypeEdit.isNotEmpty && currentColorEdit.isNotEmpty && currentGenderEdit.isNotEmpty) {
      setState(() {
        clothesList[index].type = currentTypeEdit;
        clothesList[index].color = currentColorEdit;
        clothesList[index].gender = currentGenderEdit;
      });
    }
  }

  void deleteClothes(int index) {
    setState(() {
      clothesList.removeAt(index);
    });
  }
}