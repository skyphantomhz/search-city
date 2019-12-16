import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/model/city.dart';

class SearchCity extends StatefulWidget {
  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  final inputController = TextEditingController();
  CityBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<CityBloc>(context);
    bloc.addListener();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          TextField(
            controller: inputController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Typing city or postal code',
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0)),
            onChanged: (keyWord) {
              bloc.setKeyWord(keyWord);
            },
            onSubmitted: (keyWord) {
              bloc.setKeyWord(keyWord);
            },
          ),
          Expanded(
            child: StreamBuilder<List<City>>(
              stream: bloc.cities,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("Loading.."));
                }
                var data = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return InkWell(
                        onTap: () {
                          bloc.saveLocationId(item.woeid);
                          Navigator.pop(context, 'ok');
                        },
                        child: Column(
                          children: <Widget>[
                            Text(item.qualifiedName),
                            Divider(
                              color: Colors.grey,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
