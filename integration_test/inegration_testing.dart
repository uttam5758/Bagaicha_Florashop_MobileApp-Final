import 'package:cybershop/feature/screens/navigation_screen.dart';
import 'package:cybershop/feature/presentation/view/signin.dart';
import 'package:cybershop/feature/presentation/view/signout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    "testing the widgets",
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/register': (context) => SignOut(),
        },
        home: const SignIn(),
      ));
      Finder email = find.byKey(const ValueKey("txtEmail"));
      await tester.enterText(email, "kripathapa@gmail.com");
      Finder password = find.byKey(const ValueKey("txtPassword"));
      await tester.enterText(password, "kripa123");
      Finder signup = find.byKey(const ValueKey("btnRegister"));
      await tester.dragUntilVisible(
        signup,
        find.byType(Scaffold),
        const Offset(0, 70),
      );
      await tester.tap(signup);
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsOneWidget);
    },
  );
}
