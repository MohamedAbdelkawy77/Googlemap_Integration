import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/Features/Presentation/Manager/prediction_places_cubit/prediction_places_cubit.dart';
import 'package:googlemap/Features/Presentation/Widgets/GoogleMapWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'lib/Core/transliation',
        fallbackLocale: Locale('en'),
        child: BlocProvider(
            create: (context) => PredictionPlacesCubit(), child: MapApp())),
  );
}

class MapApp extends StatelessWidget {
  const MapApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Googlemapwidget()
        //home: MyHomePage()
        );
  }
}
