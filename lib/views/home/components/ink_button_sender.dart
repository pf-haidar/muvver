import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muvver/views/transport_selection/transport_selection.dart';

Widget inkButtonSender(BuildContext context) {
  return InkWell(
    onTap: () {
      showModal(context, 'Não há nada por aqui ainda!!!');
    },
    child: Ink(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(53, 55, 64, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: const Text(
                    'Rementente',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: const Text(
                    'Para onde quer enviar seu\nobjeto?',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 17),
              child: SvgPicture.asset(
                'assets/images/ic-box.svg',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showModal(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(title),
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
