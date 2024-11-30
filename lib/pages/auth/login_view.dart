import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/pages/admin_view/admin_dashboard.dart';
import 'package:mandisetu/pages/admin_view/orders/vyapari_purchases.dart';
import 'package:mandisetu/pages/wholesaler_views/wholesaler_home.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:mandisetu/viewmodel/auth_viewmodel.dart';
import 'package:mandisetu/widget/custom_text_form_field_icon.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 60),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 246, 246),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade100,
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Center(
                child: Image.asset('assets/images/mandisetu_logo.png'),
              ),
            ),
            Material(
              elevation: 10,
              shadowColor: Colors.black,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text('Login',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 20),
                    CustomTextFormFieldWithIcon(
                      controller: _emailController,
                      prefixIcon: Icons.email,
                      label: 'Register email',
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormFieldWithIcon(
                      controller: _passwordController,
                      prefixIcon: Icons.password,
                      label: 'Password',
                    ),
                    const SizedBox(height: 15),
                    authProvider.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                dynamic data = jsonEncode({
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                });
                                // authProvider.login(context, data);
                                // Navigator.pushReplacementNamed(context, NamedRoutes.bottomTab);
                                Navigator.pushNamed(
                                    context, NamedRoutes.bottomTab);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff3A9046),
                                foregroundColor: Colors.white,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              child: const Text('Login'),
                            ),
                          ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(width: 15),
                        Text('OR'),
                        SizedBox(width: 15),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, NamedRoutes.signup);
                        },
                        style: OutlinedButton.styleFrom(
                            foregroundColor: StyleConstants.darkGreen),
                        child: const Text('Register'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminHome(),
                                ));
                          },
                          child: const Text('Login as Admin'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WholesalerHomeView(),
                                ));
                          },
                          child: const Text('Login as wholesaler'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
