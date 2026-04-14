import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/Features/Presentation/Widgets/GoogleMapWidget.dart';

void main() {
  // runApp(DevicePreview(
  //   builder: (context) => MapApp(),
  //   enabled: true,
  // ));
  runApp(MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Googlemapwidget()
        //home: MyHomePage()
        );
  }
}
