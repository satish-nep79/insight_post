import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insight_post/common/widgets/generic_button.dart';
import 'package:insight_post/common/widgets/generic_textfield.dart';
import 'package:insight_post/features/dashboard/views/dashboard_screen.dart';
import 'package:insight_post/utils/validators.dart';

class EmailSetupScreen extends ConsumerStatefulWidget {
  const EmailSetupScreen({super.key});

  @override
  ConsumerState<EmailSetupScreen> createState() => _EmailSetupScreenState();
}

class _EmailSetupScreenState extends ConsumerState<EmailSetupScreen> {
  _EmailSetupScreenState();

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final isFormFilled = ValueNotifier(false);

  _checkFormFilled() {
    isFormFilled.value = emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          GenericTextField(
            hint: "Email",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
            controller: emailController,
            onValueChange: (_) => _checkFormFilled(),
            validator: Validators.checkEmailField,
          ),
          SizedBox(
            height: 30.h,
          ),
          ValueListenableBuilder(
              valueListenable: isFormFilled,
              builder: (context, value, _) {
                return GenericButton(
                  isDisabled: !value,
                  title: "Continue",
                  onTap: _onSubmit,
                );
              })
        ],
      ),
    );
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.go(
        DashboardScreen.route,
      );
    }
  }
}
