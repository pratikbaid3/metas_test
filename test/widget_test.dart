import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metas_test/modules/dashboard/apis/character_provider.dart';
import 'package:metas_test/modules/dashboard/models/character_model.dart';
import 'package:metas_test/modules/dashboard/widgets/character_detail_widget.dart';
import 'package:metas_test/modules/dashboard/widgets/list_widget.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('renders character list correctly', (WidgetTester tester) async {
    // Create a mock CharacterProvider with sample data
    final characterProvider = CharacterProvider();
    characterProvider.characters = [
      CharacterModel(name: 'Character 1', image: 'image_url_1'),
      CharacterModel(name: 'Character 2', image: 'image_url_2'),
    ];

    // Build the CharacterListWidget wrapped in a ChangeNotifierProvider
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: characterProvider,
          child: const CharacterListWidget(),
        ),
      ),
    );

    // Verify the presence of both characters in the list
    expect(find.text('Character 1'), findsOneWidget);
    expect(find.text('Character 2'), findsOneWidget);

    // Tap on the first character
    await tester.tap(find.text('Character 1'));
    await tester.pumpAndSettle();

    // Verify that the character detail widget is navigated to
    expect(find.byType(CharacterDetailWidget), findsOneWidget);
  });
}
