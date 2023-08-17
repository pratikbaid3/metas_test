import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:metas_test/modules/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/extensions.dart';
import '../../../services/network_service.dart';
import '../models/character_model.dart';

class CharacterProvider extends ChangeNotifier {
  final TextEditingController characterSearchController =
      TextEditingController();

  List<CharacterModel> characters = [];
  CharacterModel? selectedCharacter;

  Future<void> getCharacterList(BuildContext context) async {
    final homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    EasyLoading.show();
    Response response =
        await NetworkService.get(url: homeProvider.config?.api ?? "");
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      characters = List<CharacterModel>.from(
        jsonDecode(response.body)["RelatedTopics"].map(
          (json) => CharacterModel.fromJson(json),
        ),
      );
      notifyListeners();
    }
  }

  void setSelectedCharacter({required CharacterModel model}) {
    selectedCharacter = model;
    notifyListeners();
  }
}
