import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:muvver/controllers/page_route_controller.dart';
import 'package:muvver/views/destiny_selection/page/map_page.dart';
import 'package:muvver/views/map_screen/map_screen.dart';

class RoutePage extends StatefulWidget {
  RoutePage({Key? key, }) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  DateTime date = DateTime.now();
  TextEditingController controllerDeparture = TextEditingController();
  TextEditingController controllerArrival = TextEditingController();
  TextEditingController controllerOriginCity = TextEditingController();
  TextEditingController controllerTargetCity = TextEditingController();
  PageRouteController controller = PageRouteController();

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(controller.apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25, left: 25),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Selecione a data e rota da sua viagem',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextField(
                          controller: controllerArrival,
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
                              controllerArrival.text =
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
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextField(
                          controller: controllerDeparture,
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
                              controllerDeparture.text =
                                  DateFormat("dd/MM/yyyy").format(newDate);
                            });
                            print(controllerDeparture.text);
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
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
                  child: TextField(
                    controller: controllerOriginCity,
                    focusNode: startFocusNode,
                    decoration: InputDecoration(
                        labelText: "Cidade de Origem",
                        border: const OutlineInputBorder(),
                        suffixIcon: controllerOriginCity.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    predictions = [];
                                    controllerOriginCity.clear();
                                  });
                                },
                                icon: Icon(Icons.clear_outlined),
                              )
                            : null),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(seconds: 1), () {
                        if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                        } else {
                          setState(() {
                            predictions = [];
                            startPosition = null;
                          });
                        }
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
                  child: TextField(
                    controller: controllerTargetCity,
                    focusNode: endFocusNode,
                    enabled: controllerOriginCity.text.isNotEmpty &&
                        startPosition != null,
                    decoration: InputDecoration(
                        labelText: "Cidade de Destino",
                        border: const OutlineInputBorder(),
                        suffixIcon: controllerTargetCity.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    predictions = [];
                                    controllerTargetCity.clear();
                                  });
                                },
                                icon: Icon(Icons.clear_outlined),
                              )
                            : null),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(seconds: 1), () {
                        if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                        } else {
                          setState(() {
                            predictions = [];
                            endPosition = null;
                          });
                        }
                      });
                    },
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  itemCount: predictions.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () async {
                        final placeId = predictions[index].placeId;
                        final details = await googlePlace.details.get(placeId!);
                        if (details != null &&
                            details.result != null &&
                            mounted) {
                          if (startFocusNode.hasFocus) {
                            setState(() {
                              startPosition = details.result;
                              controllerOriginCity.text = details.result!.name!;
                              predictions = [];
                            });
                          } else {
                            setState(() {
                              endPosition = details.result;
                              controllerTargetCity.text = details.result!.name!;
                              predictions = [];
                            });
                          }
                        }
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromRGBO(36, 185, 110, 1),
                        child: Icon(Icons.pin_drop, color: Colors.white),
                      ),
                      title: Text(
                        predictions[index].description.toString(),
                      ),
                    );
                  }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(36, 185, 110, 1),
                    ),
                    child: const Text(
                      'AVANÇAR',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (startPosition != null &&
                          endPosition != null &&
                          controllerArrival.text.isNotEmpty &&
                          controllerDeparture.text.isNotEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => MapScreen(startPosition: startPosition, endPosition: endPosition)),
                          ),
                        );
                      } else {
                        showModal();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Preencha todos os campos para continuar!'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }
}
