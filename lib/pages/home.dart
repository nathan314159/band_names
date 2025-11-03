import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 3),
    Band(id: '3', name: 'Héroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction){
        print('direction: $direction');
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 30)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  void addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      // 🟩 Android-style dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("New band name"),
            content: TextField(controller: textController),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => addNewBandToList(textController.text),
                child: const Text("Add"),
              ),
            ],
          );
        },
      );
    } else {
      // 🍏 iOS-style dialog
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("New band name"),
            content: CupertinoTextField(controller: textController),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => addNewBandToList(textController.text),
                child: const Text("Add"),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text("Dismiss"),
              ),
            ],
          );
        },
      );
    }
  }

  void addNewBandToList(String name) {
    if (name.isNotEmpty) {
      setState(() {
        bands.add(
          Band(
            id: DateTime.now().toString(), // unique id
            name: name,
            votes: 0,
          ),
        );
      });

      Navigator.pop(context); // closes the dialog
    }
  }
}
