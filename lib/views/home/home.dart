import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muvver/views/home/components/ink_button_sender.dart';
import 'package:muvver/views/home/components/ink_button_traveller.dart';
import 'package:muvver/views/transport_selection/transport_selection.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(36, 185, 110, 1),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.grey[300],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: 'Avisos',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment_rounded,
              ),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.delivery_dining_rounded,
              ),
              label: 'Entregue',
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:
                        SvgPicture.asset('assets/images/logo.svg', height: 16),
                  ),
                  Container(
                    child: Image.asset('assets/images/thomas.png', height: 50),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Facilitando seus ",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text("envios.",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Entregue ou envie.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: inkButtonSender(context),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: inkButtonTraveller(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
