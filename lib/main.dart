import 'package:flutter/material.dart';
import 'package:zoondia_test/bloc.dart';
import 'package:zoondia_test/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
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
  Block _block = Block();
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () => _block.fetchAllItems(),
        child: StreamBuilder(
          stream: _block.itemsStream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text("Error"),
              );
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                List<ItemsModel> _itemModel = snapshot.data;
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    // return Text(_itemModel[index].title);
                    return Column(children: [
                      Expanded(
                        child: Image.network(
                          _itemModel[index].media.m.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Text(_itemModel[index].title),
                      )
                    ]);
                  },
                );
                break;
              case ConnectionState.none:
                return Center(child: Text("No data"));
                break;
              case ConnectionState.waiting:
                return Center(child: Text("Loading"));
                break;
              default:
                return Center(child: Text("No data"));
            }
          },
        ),
      ),
    );
  }
}
