import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TextScreen());
  }
}

class TextScreen extends StatefulWidget {
  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  String _texte = 'Texte editable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutes amb paràmetres'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_texte),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Edita'),
              onPressed: () {
                // si cream nosaltres el MaterialPageRoute, li hem de passar
                // la informació a través del constructor.
                // Podrem recuperar la informació que ens retorni el Pop des
                // del Future (Alerta si es null!!)
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => EditScreen(_texte),
                ))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _texte = value;
                    });
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  final String texte;

  EditScreen(this.texte);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState

    // Podem accedir a les variables del propi Widget amb this.widget
    _controller = TextEditingController(text: widget.texte);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutes amb paràmetres'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _controller),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Desa'),
              onPressed: () {
                // Aquí ara hem de retonrar el valor de _controller.text
                Navigator.of(context).pop(_controller.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
