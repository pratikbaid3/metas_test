import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_color.dart';
import '../../../constants/responsive_size.dart';
import '../apis/character_provider.dart';
import '../widgets/character_detail_widget.dart';
import '../widgets/list_widget.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CharacterProvider>(context, listen: false)
          .getCharacterList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Character Viewer"),
      ),
      body: size.width > respWidth
          ? Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: CharacterListWidget(),
                ),
                Expanded(
                  flex: 7,
                  child: CharacterDetailWidget(),
                )
              ],
            )
          : const CharacterListWidget(),
    );
  }
}
