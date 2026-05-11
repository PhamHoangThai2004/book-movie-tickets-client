import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/toasts/shimmer_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/screens/ticket/components/ticket_item.dart';
import 'package:client/screens/ticket/components/ticket_item_shimmer.dart';
import 'package:client/screens/ticket/cubit/ticket_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/customs/toasts/loading_custom.dart';
import '../../core/customs/toasts/toast_custom.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/size_config/size_config.dart';
import '../../data/enums/status_enum.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.ticketCubit.fetchTickets();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<TicketCubit>().state;
    if (state.isLoadingMore) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 500) {
      context.ticketCubit.loadMoreTickets();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<TicketCubit, TicketState>(
                listenWhen: (previous, current) => previous.status != current.status,
                listener: (context, state) {
                  if (state.status.isFailure) {
                    ToastCustom.show(message: state.errorMessage);
                  }
                },
              ),
              BlocListener<TicketCubit, TicketState>(
                listenWhen: (previous, current) => previous.statusDetail != current.statusDetail,
                listener: (context, state) {
                  if (state.statusDetail.isProcessing) {
                    LoadingCustom.show();
                  }
                  else if (state.statusDetail.isSuccess) {
                    LoadingCustom.hideLoading();
                    context.pushNamed(NavigationService.ticketDetail, extra: state.ticket);
                  } else if (state.statusDetail.isFailure) {
                    LoadingCustom.hideLoading();
                    ToastCustom.show(message: state.errorMessage);
                  }
                },
              ),
            ],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: BlocBuilder<TicketCubit, TicketState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'my_tickets'.tr(),
                          style: AppTextStyles.style.s28.w700.whiteSmokeColor,
                        ),
                      ),
                      VerticalSpacing(of: Dimens.d24.responsive()),
                      Expanded(
                        child: RefreshIndicator(
                          color: AppColors.amberYellow,
                          onRefresh: () => context.ticketCubit.fetchTickets(),
                          child: _buildContent(state),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TicketState state) {
    return BlocBuilder<TicketCubit, TicketState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
        if (state.status.isProcessing) {
          return _buildLoadingShimmer();
        } else if (state.status.isFailure) {
          return Center(child: Text(state.errorMessage, style: AppTextStyles.style.s16.whiteColor));
        } else if (state.status.isSuccess && state.ticketsList.isNotEmpty) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.ticketsList.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == state.ticketsList.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.amberYellow),
                      ),
                    ),
                  ),
                );
              }

              return TicketItem(ticket: state.ticketsList[index]);
            },
          );
        } else {
          return Center(
            child: Text('no_tickets_found'.tr(), style: AppTextStyles.style.s16.whiteColor),
          );
        }
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return ShimmerCustom(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (_, _) => const TicketItemShimmer(),
      ),
    );
  }
}
