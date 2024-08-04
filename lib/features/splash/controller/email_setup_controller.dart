import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailSetupProvider = StateNotifierProvider<EmailSetupNotifier, String>(
  (ref) {
    return EmailSetupNotifier("");
  },
);

class EmailSetupNotifier extends StateNotifier<String> {
  EmailSetupNotifier(super.state);
}
