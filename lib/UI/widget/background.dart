import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/UI/utils/assets_path.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          SafeArea(child:SvgPicture.asset(AssetsPath.backgroundpath)),
          child
        ],
    );
  }
}