import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/screens/payment_history/components/payment_history_item.dart';
import 'package:client/screens/payment_history/components/payment_history_item_shimmer.dart';
import 'package:client/screens/payment_history/cubit/payment_history_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/register_cubit.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/size_config/size_config.dart';
import '../../data/enums/status_enum.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.paymentHistoryCubit.fetchBookingHistory();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<PaymentHistoryCubit>().state;
    if (state.status == StatusEnum.processing) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 500) {
      context.paymentHistoryCubit.loadMoreBookings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBlack,
      body: MultiBlocListener(
        listeners: [
          BlocListener<PaymentHistoryCubit, PaymentHistoryState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure && state.errorMessage.isNotEmpty) {
                ToastCustom.show(message: state.errorMessage);
              }
            },
          ),
          BlocListener<PaymentHistoryCubit, PaymentHistoryState>(
            listenWhen: (previous, current) => previous.statusLoad != current.statusLoad,
            listener: (context, state) {
              if (state.statusLoad.isProcessing) {
                LoadingCustom.show();
              }
              else if (state.statusLoad.isSuccess && state.payment != null) {
                LoadingCustom.hideLoading();
                context.pushNamed(NavigationService.paymentDetail, extra: state.payment!);
              }
              else if (state.statusLoad.isFailure) {
                LoadingCustom.hideLoading();
                ToastCustom.show(message: state.errorMessage);
              }
            },
          ),
        ],
        child: SafeArea(
          child: Container(
            decoration: AppThemes.mainBackground,
            child: Column(
              children: [
                VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
                  child: HeaderCustom(title: 'payment_history'.tr()),
                ),
                VerticalSpacing(of: Dimens.d24.responsive()),
                BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
                  builder: (context, state) {
                    final payments = state.payments?.items ?? [];

                    if (state.status.isProcessing && payments.isEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(Dimens.d16.responsive()),
                          itemCount: 6,
                          itemBuilder: (_, _) => const PaymentHistoryItemShimmer(),
                        ),
                      );
                    }

                    if (state.status.isFailure && payments.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.errorMessage.isEmpty
                                    ? 'error_occurred'.tr()
                                    : state.errorMessage,
                                style: AppTextStyles.style.s16.copyWith(color: AppColors.silver),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: Dimens.d24.responsive()),
                              ButtonCustom(
                                onPressed: () {
                                  context.paymentHistoryCubit.refreshBookingHistory();
                                },
                                width: Dimens.d100.responsive(),
                                title: 'retry'.tr(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (payments.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.silver),
                              SizedBox(height: Dimens.d16.responsive()),
                              Text(
                                'not_have_payment_history'.tr(),
                                style: AppTextStyles.style.s16.copyWith(color: AppColors.silver),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => context.paymentHistoryCubit.refreshBookingHistory(),
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(Dimens.d16.responsive()),
                          itemCount: payments.length,
                          itemBuilder: (context, index) {
                            final payment = payments[index];
                            return PaymentHistoryItem(payment: payment);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
