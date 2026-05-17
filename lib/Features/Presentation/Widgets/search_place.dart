import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/Features/Presentation/Manager/prediction_places_cubit/prediction_places_cubit.dart';
import 'package:googlemap/Features/Presentation/Manager/prediction_places_cubit/prediction_places_state.dart';
import 'package:googlemap/Features/Presentation/Widgets/googlemapinfo.dart';

// ignore: must_be_immutable
class SearchPlace extends StatefulWidget {
  SearchPlace({super.key});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  TextEditingController textcontroller = TextEditingController();

  List<String> test1 = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: "text now", fillColor: Colors.amberAccent),
            onChanged: (val) {
              context.read<PredictionPlacesCubit>().getpredictionplaces(val);
            },
            controller: textcontroller,
          ),
        ),
        Expanded(
          child: BlocBuilder<PredictionPlacesCubit, PredictionPlacesState>(
            builder: (context, state) {
              if (state is PredictionPlacesStateSuccess) {
                return ListView.builder(
                    itemCount: state.places.length,
                    itemBuilder: (constext, index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<PredictionPlacesCubit>()
                              .getplaceinfo(state.places[index].placeId);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Googlemapinfo()));
                        },
                        child: Text(
                          state.places[index].text.text,
                          style: TextStyle(color: Colors.deepOrangeAccent),
                        ),
                      );
                    });
              } else if (state is PredictionPlacesStateFailur) {
                return Text(
                  state.message,
                  style: TextStyle(color: Colors.cyanAccent),
                );
              } else {
                return Center(child: Text("search now"));
              }
            },
          ),
        )
      ],
    );
  }
}
