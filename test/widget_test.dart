import 'package:estok_app/models/historic_model.dart';
import 'package:estok_app/models/product_stock_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:estok_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(UserModel(), StockModel(), ProductStockModel(), HistoricModel()));
  });
}
