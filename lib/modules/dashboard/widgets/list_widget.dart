import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/responsive_size.dart';
import '../apis/character_provider.dart';
import '../models/character_model.dart';
import 'character_detail_widget.dart';

class CharacterListWidget extends StatefulWidget {
  const CharacterListWidget({Key? key}) : super(key: key);

  @override
  State<CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<CharacterProvider>(
        builder: (context, characterProvider, child) {
      List<CharacterModel> items = characterProvider.characters;
      return Column(
        children: [
          TextField(
            controller: characterProvider.characterSearchController,
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                CharacterModel item = items[index];
                if ((item.name ?? "").toLowerCase().contains(characterProvider
                        .characterSearchController.text
                        .toLowerCase()) ||
                    (item.description ?? "").toLowerCase().contains(
                        characterProvider.characterSearchController.text
                            .toLowerCase())) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(items[index].name.toString()),
                      leading: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl: items[index].image.toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image),
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Provider.of<CharacterProvider>(context, listen: false)
                            .setSelectedCharacter(model: items[index]);
                        if (respWidth > size.width) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CharacterDetailWidget(
                                poppable: true,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      );
    });
  }
}
