import 'package:flutter/material.dart';
import 'package:restaurant_finder_new/BLoC/bloc_provider.dart';
import 'package:restaurant_finder_new/BLoC/location_bloc.dart';
import 'package:restaurant_finder_new/BLoC/location_query_bloc.dart';
import 'package:restaurant_finder_new/DataLayer/location.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloc();
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Where do you want to eat?'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a location',
                ),
                onChanged: (query) {
                  bloc.submitQuery(query);
                },
              ),
            ),
            Expanded(
              child: _buildResults(bloc),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder(
      stream: bloc.locationStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // 1
        final results = snapshot.data;

        if(results == null) {
          return Center(
            child: Text('Enter a location'),
          );
        }

        if(results.isEmpty) {
          return Center(
            child: Text('No Results'),
          );
        }
        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    // 2
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            // 3
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc.selectLocation(location);

            if (isFullScreenDialog) {
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }
}
