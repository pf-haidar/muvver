import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muvver/views/transport_selection/transport_selection.dart';

Widget inkButtonTraveller(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TransportSelection(),
        ),
      );
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
                    'Viajante',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: const Text(
                    'Vai viajar para onde?',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset(
                'assets/images/delivery-truck.svg',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
