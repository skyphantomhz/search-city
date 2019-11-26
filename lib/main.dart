import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/model/city.dart';
import 'package:search_city/util/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search City',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CityBloc>(
        creator: (_context, _bag) => CityBloc(),
        child: MyHomePage(title: 'Search city'),
        autoDispose: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final inputController = TextEditingController();
  CityBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<CityBloc>(context);
    bloc.addListener();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: inputController,
            decoration: InputDecoration(
                hintText: 'Typing city or postal code',
                fillColor: Colors.black12,
                contentPadding: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0)),
            onChanged: (keyWord) {
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
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Selected: ${item.woeid}"),
                              action: SnackBarAction(
                                label: "OK",
                                onPressed: () {},
                              ),
                            ));
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
                }),
          ),
        ],
      ),
    );
  }
}
