import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DestinySelection extends StatefulWidget {
  const DestinySelection({Key? key}) : super(key: key);

  @override
  State<DestinySelection> createState() => _DestinySelectionState();
}

class _DestinySelectionState extends State<DestinySelection> {
  final PageController controllerPage = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(53, 55, 64, 1),
          centerTitle: true,
          title: const Text('Viajante'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 24),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 1,
                height: 80,
                color: const Color.fromRGBO(53, 55, 64, 1),
                child: const Text(
                  "Qual o trajeto da sua viagem?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 40,
                color: const Color.fromRGBO(53, 55, 64, 1),
                child: TabBarView(
                  children: [
                    Text(
                      "Rotas",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
