import 'dart:async';

import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/inputs/search_field_custom.dart';
import 'package:client/screens/search/components/search_filter_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/customs/buttons/cupertino_button_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/search_cubit.dart';

class SearchHeaderLayout extends StatefulWidget {
  const SearchHeaderLayout({super.key});

  @override
  State<StatefulWidget> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeaderLayout> {
  late TextEditingController _searchController;
  Timer? _debounceTimer;
  static const int _debounceDelayMs = 500; // ⏱️ 0.5 giây

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchFieldCustom(
                prefix: Assets.svgs.icSearch,
                controller: _searchController,
                textStyle: AppTextStyles.style.s15.w400.whiteColor,
                onChanged: (value) {
                  // Cancel previous timer
                  _debounceTimer?.cancel();
                  
                  // Set new debounce timer
                  _debounceTimer = Timer(
                    const Duration(milliseconds: _debounceDelayMs),
                    () => context.searchCubit.searchMovies(value),
                  );
                },
                hintText: 'enter_search'.tr(),
                onClickSuffix: () {
                  _debounceTimer?.cancel();
                  context.searchCubit.searchMovies('');
                },
                hintStyle: AppTextStyles.style.s14.w400.coolGrayColor,
              ),
            ),
            HorizontalSpacing(of: Dimens.d8.responsive()),
            CupertinoButtonCustom(
              onPressed: () => showFilterBottomSheet(context: context),
              child: BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (previous, current) =>
                previous.selectedStatus != current.selectedStatus ||
                    previous.selectedGenre != current.selectedGenre,
                builder: (context, state) {
                  final hasFilter = state.selectedStatus != null || state.selectedGenre != null;
                  return Container(
                    padding: EdgeInsets.all(Dimens.d12.responsive()),
                    decoration: BoxDecoration(
                      color: hasFilter
                          ? AppColors.amberYellow
                          : AppColors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
                    ),
                    child: Row(
                      spacing: Dimens.d8.responsive(),
                      children: [
                        Assets.svgs.icFilterList.svg(
                          width: Dimens.d20.responsive(),
                          height: Dimens.d20.responsive(),
                          colorFilter: ColorFilter.mode(
                            hasFilter ? AppColors.black : AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text('filter'.tr(), style: AppTextStyles.style.s14.w500.copyWith(
                          color: hasFilter ? AppColors.black : AppColors.white,
                        )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
