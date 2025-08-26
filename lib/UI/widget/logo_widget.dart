import 'package:flutter/material.dart';
import 'package:task_manager/UI/utils/assets_path.dart';

class logo extends StatelessWidget {
  const logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(AssetsPath.logopath,height:200,width: 450,),);
  }
}