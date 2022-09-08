import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:muvver/utils/map_utils.dart';

class MapScreen extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;
  const MapScreen({Key? key, this.startPosition, this.endPosition})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialPosition;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    initialPosition = CameraPosition(
      target: LatLng(widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!),
      zoom: 50.0,
    );
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: const Color.fromRGBO(36, 185, 110, 1),
      points: polylineCoordinates,
      width: 1,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBW2JTkJNYLh3PUOS4ejgowK7fXGCHqrIk',
        PointLatLng(widget.startPosition!.geometry!.location!.lat!,
            widget.startPosition!.geometry!.location!.lng!),
        PointLatLng(widget.endPosition!.geometry!.location!.lat!,
            widget.endPosition!.geometry!.location!.lng!),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {
      Marker(
          markerId: MarkerId('start'),
          position: LatLng(widget.startPosition!.geometry!.location!.lat!,
              widget.startPosition!.geometry!.location!.lng!)),
      Marker(
          markerId: MarkerId('end'),
          position: LatLng(widget.endPosition!.geometry!.location!.lat!,
              widget.endPosition!.geometry!.location!.lng!)),
    };

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: GoogleMap(
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: initialPosition,
        markers: Set.from(markers),
        onMapCreated: (GoogleMapController controller) {
          Future.delayed(
            Duration(seconds: 2),
            () {
              controller.animateCamera(
                CameraUpdate.newLatLngBounds(
                    MapUtils.boundsFromLatLngList(
                        markers.map((loc) => loc.position).toList()),
                    1),
              );
              _getPolyline();
            },
          );
        },
      ),
    );
  }
}
