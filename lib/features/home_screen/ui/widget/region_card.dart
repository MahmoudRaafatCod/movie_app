import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';

class RegionCard extends StatelessWidget {
  final String name;
  final VoidCallback onViewMore;

  const RegionCard({super.key, required this.name, required this.onViewMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.textColor,
            ),
          ),
          TextButton(
            onPressed: onViewMore,
            child: Text(
              "seeAll".tr(),
              style: TextStyle(color: context.primaryColor, fontSize: 13 , fontWeight: context.isEnglish ? FontWeight.bold : FontWeight.normal , fontFamily: Assets.cairoFont),
            ),
          ),
        ],
      ),
    );
  }
}
