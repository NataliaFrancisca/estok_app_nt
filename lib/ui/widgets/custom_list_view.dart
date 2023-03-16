import 'package:estok_app_natalia_francisca/ui/widgets/custom_card_stock.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class CustomListView extends StatefulWidget {
  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data/fake_data.json');
    final data = await json.decode(response);

    setState(() {
      _items = data['stock'];
    });
  }

  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return _items.isNotEmpty ? Container(
            child: Center(
                child: CustomCardStock(
                  stockCardTitle: _items[index]["stock_name"],
                  totalStock: _items[index]["stock_total"],
                  typeGrid: _items[index]["stock_type_grid"],
                )
            ),
          ) : Text("Nothing was not found");
        }
    );
  }
}
