import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muvver/views/destiny_selection/page/map_page.dart';
import 'package:muvver/views/destiny_selection/page/route_page.dart';
import 'package:muvver/views/home/home.dart';

class DestinySelection extends StatefulWidget {
  const DestinySelection({Key? key}) : super(key: key);

  @override
  State<DestinySelection> createState() => _DestinySelectionState();
}

class _DestinySelectionState extends State<DestinySelection> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 16),
                child: Text(
                  "Cancelar",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
          bottom: const TabBar(
            indicatorColor: Color.fromRGBO(36, 185, 110, 1),
            tabs: [
              Tab(text: 'Rotas'),
              Tab(text: 'Mapa'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RoutePage(),
            MapPage(),
          ],
        ),
      ),
    );
  }
}
