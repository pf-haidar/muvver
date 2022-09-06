import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muvver/models/transport_model.dart';
import 'package:muvver/views/transport_selection/components/transport_list_tile_widget.dart';

class TransportSelection extends StatefulWidget {
  const TransportSelection({Key? key}) : super(key: key);

  @override
  State<TransportSelection> createState() => _TransportSelectionState();
}

class _TransportSelectionState extends State<TransportSelection> {
  List<Transport> allTransports = [
    Transport(name: 'Carro'),
    Transport(name: 'Avião'),
    Transport(name: 'Caminhão'),
    Transport(name: 'Van'),
    Transport(name: 'Moto'),
    Transport(name: 'Bicicleta'),
    Transport(name: 'Ônibus'),
    Transport(name: 'Embarcação'),
  ];

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
            child: const Icon(Icons.close),
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
                  "Qual será o meio de transporte da sua viagem?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Transporte',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                itemCount: allTransports.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return TransportListTileWidget(
                      transport: allTransports[index],
                      isSelected: false,
                      onSelectedTransport: selectTransport);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectTransport(Transport transport) {}
}
