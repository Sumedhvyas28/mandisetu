import 'package:flutter/material.dart';
import 'package:mandisetu/pages/auth/register/agrement_form.dart';
import 'package:mandisetu/pages/auth/register/basic_bank_details.dart';
import 'package:mandisetu/pages/auth/register/business_details.dart';
import 'package:mandisetu/pages/auth/register/page_1_personal_detial.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int currentIndex = 1;

  void onClicked() {
    if (currentIndex > 3) {
      setState(() {
        currentIndex = 1;
      });
    } else {
      setState(() {
        currentIndex = currentIndex + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (currentIndex == 1)
                Expanded(
                    child: Page1PersonalDetail(
                  onClick: onClicked,
                )),
              if (currentIndex == 2)
                Expanded(
                    child: BusinessDetail(
                  onClick: onClicked,
                )),
              if (currentIndex == 3)
                Expanded(
                    child: BasicBankDetail(
                  onClick: onClicked,
                )),
              if (currentIndex == 4)
                const Expanded(
                  child: AgreementForm(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
