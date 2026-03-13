class DashboardState {
  final int currentIndex;

  const DashboardState({required this.currentIndex});

  DashboardState copyWith({int? currentIndex}) {
    return DashboardState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
