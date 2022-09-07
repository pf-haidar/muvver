import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:muvver/controllers/page_route_controller.dart';

class RoutePage extends StatefulWidget {
  RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  DateTime date = DateTime.now();
  TextEditingController controllerPartida = TextEditingController();
  TextEditingController controllerChegada = TextEditingController();
  TextEditingController controllerCidadeOrigem = TextEditingController();
  TextEditingController controllerCidadeDestino = TextEditingController();
  PageRouteController controller = PageRouteController();

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(controller.apiKey);
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 25, left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  'Selecione a data e rota da sua viagem',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: TextField(
                      controller: controllerChegada,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          locale: const Locale('pt'),
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2030),
                        );
                        if (newDate == null) return;
                        setState(() {
                          controllerChegada.text =
                              DateFormat("dd/MM/yyyy").format(newDate);
                        });
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Data de partida",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: TextField(
                      controller: controllerPartida,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          locale: const Locale('pt'),
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2030),
                        );
                        if (newDate == null) return;
                        setState(() {
                          controllerPartida.text =
                              DateFormat("dd/MM/yyyy").format(newDate);
                        });
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Data de chegada",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.89,
                child: TextField(
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(seconds: 1), () {
                      if (value.isNotEmpty) {
                        autoCompleteSearch(value);
                      } else {}
                    });
                  },
                  controller: controllerCidadeOrigem,
                  decoration: InputDecoration(
                    labelText: "Cidade de Origem",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.89,
                child: TextField(
                  controller: controllerCidadeDestino,
                  decoration: InputDecoration(
                    labelText: "Cidade de Destino",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.pin_drop, color: Colors.white),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
