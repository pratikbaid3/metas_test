import 'package:flutter/cupertino.dart';
import 'package:metas_test/flavour_config.dart';

class HomeProvider extends ChangeNotifier {
  FlavourConfig? _flavourConfig;

  HomeProvider({required FlavourConfig config}) {
    _flavourConfig = config;
  }

  FlavourConfig? get config => _flavourConfig;
}
