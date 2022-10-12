import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Mario Bros'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static double gabrielax = 0.0;
  static double gabrielay = 1.0;
  static double mariox = 0.8;
  static double marioy = 1.0;
  static double bloquex = -0.5;
  static double bloquey = -0.35;
  double time = 0;
  double height = 0;
  double initialPos = gabrielay;
  String direction = "right";
  double vidas = 10;
  int puntos = 0;
  int tiempo = 100;
  int i = 0; //Inicia el contador
  int saltos = 0;

  void preJump() {
    time = 0;
    initialPos = gabrielay;
  }

  void clash() {
    if ((mariox - gabrielax).abs() < 0.005 &&
        (marioy - gabrielay).abs() < 0.005) {
      vidas = vidas - 0.5;
    }
  }

  void saltosM() {
    if (saltos == 4) {
      puntos++;
      saltos = 0;
    }
  }
  
  void tocaBloque(){
    if((bloquex - gabrielax).abs() < 0.005){
      puntos=puntos+2;
    }
  }

  void startTimer() {
    late Timer _timer;
    _timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      if (tiempo > 0) {
        setState(() {
          tiempo--;
        });
      } else {
        _timer.cancel();
      }
      if (tiempo == 0) {
        gameOverTiempo();
      }
    });
  }

  Future<void> gameOverVidas() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Juego acabado'),
          content: SingleChildScrollView(
              child: ListBody(children: const <Widget>[
            Text('Se te acabaron las vidas'),
            Text('Suerte a la próxima')
          ])),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> gameOverTiempo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Juego acabado'),
          content: SingleChildScrollView(
              child: ListBody(children: const <Widget>[
            Text('Se te acabó el tiempo'),
            Text('Suerte a la próxima')
          ])),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void jump() {
    saltos++;
    i++;
    if (i == 1) {
      startTimer();
      i++;
    }
    if (vidas == 0) {
      gameOverVidas();
    }
    tocaBloque();
    preJump();
    saltosM();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;
      if (initialPos - height > 1) {
        setState(() {
          gabrielay = 1;
        });
      } else {
        setState(() {
          gabrielay = initialPos - height;
        });
      }
    });
  }

  void walkL() {
    i++;
    if (i == 1) {
      startTimer();
      i++;
    }
    clash();
    saltosM();
    if (vidas == 0) {
      gameOverVidas();
    }
    direction = "left";
    if (gabrielax - 0.05 > -1.05) {
      setState(() {
        gabrielax -= 0.05;
      });
    }
  }

  void walkR() {
    i++;
    if (i == 1) {
      startTimer();
      i++;
    }
    clash();
    saltosM();
    if (vidas == 0) {
      gameOverVidas();
    }
    direction = "right";
    if (gabrielax + 0.05 < 1.05) {
      setState(() {
        gabrielax += 0.05;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Container(
            color: Colors.blue,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Text('VIDAS',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    Text(vidas.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ))
                  ]),
                  Column(children: [
                    Text('PUNTOS',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    Text(puntos.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ))
                  ]),
                  Column(children: [
                    Text('TIEMPO',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    Text(tiempo.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ))
                  ]),
                ])),
        Expanded(
            flex: 4,
            child: Stack(children: [
              Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                      alignment: Alignment(gabrielax, gabrielay),
                      duration: Duration(milliseconds: 0),
                      child: Gabriela(direction: direction))),
              Container(alignment: Alignment(mariox, marioy), child: Mario()),
              Container(
                alignment: Alignment(bloquex,bloquey),
                child:Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(
                      color: Colors.brown,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('?',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900))
                ))
            ])),
        Container(height: 10, color: Colors.green),
        Expanded(
            flex: 1,
            child: Container(
                color: Colors.brown,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: walkL,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.brown[300],
                            child: Icon(Icons.arrow_back),
                          )),
                      GestureDetector(
                          onTap: jump,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.brown[300],
                            child: Icon(Icons.arrow_upward),
                          )),
                      GestureDetector(
                          onTap: walkR,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.brown[300],
                              child: Icon(Icons.arrow_forward))),
                    ])))
      ]),
    );
  }
}

class Gabriela extends StatelessWidget {
  final direction;

  Gabriela({this.direction});

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: 50,
        height: 50,
        child: Image.network(
            "https://lh3.googleusercontent.com/drive-viewer/AJc5JmRI5JCpve5rkejnJ-Bri_rLrZTwFc_MG7QG84934ykZTYVgd7xNkF_IakS3jByhhTBoZW2Yoiw=w1600-h700"),
      );
    } else {
      return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Container(
            width: 50,
            height: 50,
            child: Image.network(
                "https://lh3.googleusercontent.com/drive-viewer/AJc5JmRI5JCpve5rkejnJ-Bri_rLrZTwFc_MG7QG84934ykZTYVgd7xNkF_IakS3jByhhTBoZW2Yoiw=w1600-h700"),
          ));
    }
  }
}

class Mario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Image.network(
          "https://cdn.pixabay.com/photo/2021/02/11/15/40/mario-6005703_960_720.png"),
    );
  }
}
