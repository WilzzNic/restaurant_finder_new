import 'package:flutter/material.dart';
import 'package:restaurant_finder_new/BLoC/bloc_provider.dart';
import 'package:restaurant_finder_new/BLoC/location_bloc.dart';
import 'package:restaurant_finder_new/DataLayer/location.dart';
import 'package:restaurant_finder_new/UI/location_screen.dart';
import 'package:restaurant_finder_new/UI/restaurant_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
      stream: BlocProvider.of<LocationBloc>(context).locationStream,
      builder: (context, snapshot) {
        final location = snapshot.data;
        if(location == null) {
          return LocationScreen();
        }
        return RestaurantScreen(location: location);
      }
    );
  }
}
