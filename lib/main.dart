import 'package:estok_app/colors.dart';
import 'package:estok_app/models/historic_model.dart';
import 'package:estok_app/models/product_stock_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  runApp(MyApp(UserModel(), StockModel(), ProductStockModel(), HistoricModel()));
}

class MyApp extends StatefulWidget{
  final UserModel userScopedModel;
  final StockModel stockScopedModel;
  final ProductStockModel productStockScopedModel;
  final HistoricModel historicScopedModel;

  MyApp(this.userScopedModel, this.stockScopedModel, this.productStockScopedModel, this.historicScopedModel);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: widget.historicScopedModel,
        child: ScopedModel(
          model: widget.productStockScopedModel,
          child: ScopedModel(
            model: widget.userScopedModel,
              child: ScopedModel(
                model: widget.stockScopedModel,
                child: MaterialApp(
                  title: 'Estok App',
                  theme: ThemeData(
                    primaryColor: AppColors.primaryColor,
                    accentColor: AppColors.primaryColor,
                    
                  ),
                    debugShowCheckedModeBanner: false,
                  home: SplashScreen()
              ),
            ),
        ),
      ),
    );
  }
}
