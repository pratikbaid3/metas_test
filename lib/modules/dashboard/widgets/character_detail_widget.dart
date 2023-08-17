import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_color.dart';
import '../../../constants/responsive_size.dart';
import '../apis/character_provider.dart';

class CharacterDetailWidget extends StatelessWidget {
  final bool poppable;

  CharacterDetailWidget({Key? key, this.poppable = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (respWidth <= size.width && poppable) {
      Navigator.pop(context);
    }
    return Consumer<CharacterProvider>(
        builder: (context, characterProvider, child) {
      if (characterProvider.selectedCharacter != null) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: respWidth < size.width
              ? null
              : AppBar(
                  backgroundColor: AppColor.primary,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  title: const Text("Character Viewer"),
                ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl: characterProvider.selectedCharacter!.image
                              .toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    characterProvider.selectedCharacter!.name.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[800]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    characterProvider.selectedCharacter!.description.toString(),
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        );
      } else
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Center(
              child: Text(
            "No Character Selected",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.grey),
          )),
        );
    });
  }
}
