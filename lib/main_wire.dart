import 'package:metas_test/flavour_config.dart';
import 'package:metas_test/main_common.dart';

void main() {
  mainCommon(
      config: FlavourConfig(
          api: "http://api.duckduckgo.com/?q=the+wire+characters&format=json"));
}
