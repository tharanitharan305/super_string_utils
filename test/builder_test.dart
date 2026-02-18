import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_string_utils/super_string_utils.dart';

void main() {
  group('TextListBuilder', () {
    testWidgets('Basic row construction', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ['A', 'B'].toTextRow().build(),
        ),
      ));
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('Per-index expansion', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              ['A', 'B'].toTextRow().expandAt(1).build(),
            ],
          ),
        ),
      ));

      // Find the Expanded widget wrapping B
      // Hierarchy: Expanded -> Text('B') (or wrapper -> Text)
      final textB = find.text('B');
      final expanded = find.ancestor(of: textB, matching: find.byType(Expanded));
      expect(expanded, findsOneWidget);

      // A should not be expanded
      final textA = find.text('A');
      final expandedA = find.ancestor(of: textA, matching: find.byType(Expanded));
      expect(expandedA, findsNothing);
    });

    testWidgets('Per-index container decoration', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ['A'].toTextRow().containerAt(0, color: Colors.red).build(),
        ),
      ));

      final container = find.ancestor(of: find.text('A'), matching: find.byType(Container));
      expect(container, findsOneWidget);
      final widget = tester.widget<Container>(container);
      expect(widget.color, Colors.red);
    });

    testWidgets('Immutability check', (tester) async {
      final builder1 = ['A'].toTextRow();
      final builder2 = builder1.expandAt(0);

      // builder1 should not produce expanded
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(children: [builder1.build()]),
        ),
      ));
      expect(find.byType(Expanded), findsNothing);

      // builder2 should
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(children: [builder2.build()]),
        ),
      ));
      expect(find.byType(Expanded), findsOneWidget);
    });
  });

  group('TextBuilder', () {
    testWidgets('Expanded builder', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(children: [
            "Test".toTextBuilder.expanded().build()
          ]),
        ),
      ));
      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('Container wrapping', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: "Test".toTextBuilder.insideContainer(color: Colors.blue).build(),
        ),
      ));
      final container = find.byType(Container);
      expect(container, findsOneWidget);
      expect(tester.widget<Container>(container).color, Colors.blue);
    });
  });

  group('SnackbarBuilder', () {
    testWidgets('Floating configuration', (tester) async {
      final snackbar = "Hi".toSnackbarBuilder.floating().build();
      expect(snackbar.behavior, SnackBarBehavior.floating);
    });
  });
}