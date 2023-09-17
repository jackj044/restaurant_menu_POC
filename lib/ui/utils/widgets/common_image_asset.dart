import 'package:restaurant_menu_poc/ui/utils/widgets/cache_image.dart';
import 'package:flutter/material.dart';

class CommonImageAsset extends StatelessWidget {
  final String strIcon;
  final Color? clrImg;
  final BlendMode? clrBlendMode;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const CommonImageAsset({Key? key, this.strIcon = '', this.clrImg, this.clrBlendMode, this.height, this.width, this.boxFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      strIcon,
      //color: clrImg,
      //colorBlendMode: clrBlendMode,
      height: height!,
      width: width!,
      fit: boxFit ?? BoxFit.fill,
    );
  }
}
