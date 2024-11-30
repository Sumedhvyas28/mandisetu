import 'package:flutter/material.dart';
import 'package:mandisetu/constants/text_constants.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:mandisetu/viewmodel/auth_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class AgreementForm extends StatefulWidget {
  const AgreementForm({super.key});

  @override
  State<AgreementForm> createState() => _AgreementFormState();
}

class _AgreementFormState extends State<AgreementForm> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Agreement',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            TextConstants.loremText,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: value,
                onChanged: (value) {
                  setState(() {
                    this.value = value!;
                    print(value);
                  });
                },
              ),
              const Text('I agree to the terms and conditions'),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter your name"),
          ),
          const SizedBox(height: 15),
          authProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : CustomElevatedButton(
                  onClick: () {
                    // authProvider.registerUser(context);
                    Navigator.pushReplacementNamed(context, NamedRoutes.bottomTab);
                  },
                  text: 'Submit',
                ),
        ],
      ),
    );
  }
}
