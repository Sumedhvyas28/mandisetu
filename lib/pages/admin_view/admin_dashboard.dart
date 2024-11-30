import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/constants/text_constants.dart';
import 'package:mandisetu/pages/admin_view/manage_commodity.dart';
import 'package:mandisetu/pages/admin_view/manage_variey.dart';
import 'package:mandisetu/pages/admin_view/news/news_updates.dart';
import 'package:mandisetu/pages/admin_view/orders/vyapari_purchases.dart';
import 'package:mandisetu/pages/admin_view/banner_promotion/promotion_management.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // final UserSession _authService = UserSession();
  //
  // Future<void> _handleLogout(BuildContext context) async {
  //   try {
  //     await _authService.signOut();
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       NamedRoutes.onboarding,
  //           (Route<dynamic> route) => false,
  //     );
  //   } catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Logout failed: $e")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff0f0f3),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome Admin!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: StyleConstants.mediumGreen,
                              fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // _handleLogout(context);
                      },
                      icon: const Icon(Icons.logout_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: TextConstants.adminText.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (TextConstants.adminText[index] == 'Order Request') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VyapariPurchases(),
                            ));
                      } else if (TextConstants.adminText[index] ==
                          'Commodity') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManageCommodity(),
                            ));
                      } else if (TextConstants.adminText[index] == 'Banners') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PromotionManagement(),
                            ));
                      } else if (TextConstants.adminText[index] == 'News') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsUpdates(),
                            ));
                      }
                      else if (TextConstants.adminText[index] == 'Varieties') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManageVariety(),
                            ));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            bottom: BorderSide(
                                width: 4, color: StyleConstants.mediumGreen),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.add,
                            size: 40,
                          ),
                          // const SizedBox(height: 20),
                          Text(
                            TextConstants.adminText[index],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
