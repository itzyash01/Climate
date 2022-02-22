import 'package:geolocator/geolocator.dart';
class Location{
  late double latitude;
  late double longitude;
  Future<void> getCurrentLocation() async {
  try{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
     Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
       Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
    Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position=await Geolocator.getCurrentPosition();
     latitude=position.latitude;
     longitude=position.longitude;

  }
  catch(e)
  {
    print(e);
  }
  }
}