import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metas_test/flavour_config.dart';
import 'package:metas_test/modules/dashboard/apis/character_provider.dart';
import 'package:metas_test/modules/dashboard/models/character_model.dart';
import 'package:metas_test/modules/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('fetches character list successfully',
      (WidgetTester tester) async {
    final charactersData = {
      "RelatedTopics": [
        {"name": "Character 1"},
        {"name": "Character 2"},
      ]
    };

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<HomeProvider>(
              create: (context) => HomeProvider(
                config: FlavourConfig(
                    api:
                        "http://api.duckduckgo.com/?q=simpsons+characters&format=json"),
              ),
            ),
            ChangeNotifierProvider<CharacterProvider>(
              create: (context) => CharacterProvider(),
            ),
          ],
          child: Builder(
            builder: (context) => FloatingActionButton(
              onPressed: () =>
                  Provider.of<CharacterProvider>(context, listen: false)
                      .getCharacterList(context),
              child: const Text('Fetch Characters'),
            ),
          ),
        ),
      ),
    );

    // Simulate tapping the button
    await tester.tap(find.text('Fetch Characters'));
    await tester.pumpAndSettle();

    // Get the current instance of HomeProvider
    final characterProvider = Provider.of<CharacterProvider>(
        tester.element(find.byType(FloatingActionButton)));

    expect(characterProvider.characters, isA<List<CharacterModel>>());
    expect(characterProvider.characters.length, 2);
    // Add more assertions as needed
  });
}
