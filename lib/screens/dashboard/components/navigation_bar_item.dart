import 'package:client/core/customs/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/navigation/navigation_bar_type.dart';

class NavigationBarItem extends StatelessWidget {
  final NavigationBarType type;
  final bool isSelected;
  final Function() onTap;

  const NavigationBarItem({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButtonCustom(
        onPressed: onTap,
        child: Container(
          color: AppColors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isSelected ? type.iconSelected : type.icon,
              VerticalSpacing(of: Dimens.d4.responsive()),
              Text(
                type.title,
                style: AppTextStyles.style.w500.s12.copyWith(
                  color: isSelected ? AppColors.amberYellow : AppColors.lightGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
