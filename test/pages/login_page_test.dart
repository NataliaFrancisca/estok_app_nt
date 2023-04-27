import 'package:estok_app/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestable(Widget widget) => MaterialApp(home: widget);

void main(){
  testWidgets('Validating login page elements', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Find the login page elements
    final loginPageTitle = find.text('ESTOK APP');
    final loginPageSubtitle = find.text("Login");
    final emailField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);
    final buttonLoginWithTextLogin = find.widgetWithText(ElevatedButton, 'ENTRAR');

    expect(loginPageTitle, findsOneWidget);
    expect(loginPageSubtitle, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(buttonLoginWithTextLogin, findsOneWidget);
  });

  testWidgets('Validate email and password', (WidgetTester tester) async{
    final emailField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);

    // Enter invalid email and password and make login
    await tester.enterText(emailField, '');
    await tester.enterText(passwordField, '');
    await tester.tap(find.text('ENTRAR'));

    expect(find.text('Digite um e-mail valido!'), findsOneWidget);
    expect(find.text('O campo deve ter no minímo 8 caracteres'), findsOneWidget);
  });
}