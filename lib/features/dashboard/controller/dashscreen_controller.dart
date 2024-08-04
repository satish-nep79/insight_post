import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashScreenProvider =
    StateNotifierProvider.autoDispose<DashScreenController, int>(
  (ref) => DashScreenController(0),
);

class DashScreenController extends StateNotifier<int> {
  DashScreenController(super.state);

  onSelectItem(int selectedIndex) {
    state = selectedIndex;
  }
}
