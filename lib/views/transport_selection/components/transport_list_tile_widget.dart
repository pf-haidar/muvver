import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muvver/models/transport_model.dart';

class TransportListTileWidget extends StatelessWidget {
  Transport transport;
  bool isSelected = false;
  ValueChanged<Transport> onSelectedTransport;

  TransportListTileWidget({
    Key? key,
    required this.transport,
    required this.isSelected,
    required this.onSelectedTransport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelectedTransport(transport),
      title: Text(transport.name),
      trailing:
          isSelected ? Icon(Icons.circle_rounded) : Icon(Icons.circle_outlined),
    );
  }
}
