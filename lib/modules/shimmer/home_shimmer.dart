import 'package:flutter/material.dart';
import 'package:pos_app/modules/shimmer/shimmer.dart';
import 'package:pos_app/modules/shimmer/shimmer_loading.dart';

import '../../constants/constants_values.dart';
import '../../shared/component.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key, this.margin}) : super(key: key);
final double? margin;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: Component.shimmerGradient,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
      ShimmerLoading(
        isLoading: true,
        child: Container(
          height: 150,
          margin:  margin==null?EdgeInsets.all(ConstantsValues.padding):EdgeInsets.only(bottom: ConstantsValues.padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ConstantsValues.borderRadius),
          ),
        ),
      ),
      for(int i = 0; i < 3; i++)
      ShimmerLoading(
        isLoading: true,
        child: Container(
          height: 150,
          margin:  EdgeInsets.only(right:margin??ConstantsValues.padding,left:margin??ConstantsValues.padding,bottom:ConstantsValues.padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ConstantsValues.borderRadius),
          ),
        ),
      ),
        ],
      ),
    );
  }
}
