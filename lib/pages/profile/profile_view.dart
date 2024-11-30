import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/constants/text_constants.dart';
import 'package:mandisetu/pages/profile/directory/directory.dart';
import 'package:mandisetu/pages/profile/refer/refer_and_earn.dart';
import 'package:mandisetu/pages/profile/terms_and_privacy.dart';
import 'package:mandisetu/pages/retailer/retailer_view.dart';
import 'package:mandisetu/utils/component/reusable_row.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: StyleConstants.darkGreen,
          foregroundColor: Colors.white,
        ),
        body: SizedBox(
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 50,
                    child: const Icon(CupertinoIcons.person_solid,
                        color: Colors.black, size: 45),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Trader Name',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text('Indore, Madhya Pradesh'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 4),
                          Text('7879908888'),
                        ],
                      ),
                      SizedBox(width: 30),
                      Row(
                        children: [
                          Icon(
                            Icons.add_business,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 4),
                          Text('Trader'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // ListView.builder(
                  //   itemCount: TextConstants.profileOptions.length,
                  //   itemBuilder: (context, index) {
                  //     final item = TextConstants.profileOptions[index];
                  //     return ListTile(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => RetailerView(),
                  //             ));
                  //       },
                  //       leading: CircleAvatar(
                  //         backgroundColor: Colors.grey.shade200,
                  //         radius: 23,
                  //         child: Icon(
                  //           item["icon"],
                  //           size: 20,
                  //           color: const Color.fromARGB(255, 42, 42, 42),
                  //         ),
                  //       ),
                  //       title: Text(item["title"],
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyLarge!
                  //               .copyWith(fontWeight: FontWeight.w600)),
                  //       trailing: const Icon(
                  //         Icons.chevron_right,
                  //         color: Colors.black54,
                  //       ),
                  //       contentPadding: const EdgeInsets.symmetric(
                  //           vertical: 5, horizontal: 15),
                  //     );
                  //   },
                  //   padding: EdgeInsets.zero,
                  //   shrinkWrap: true,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        IconTextRow(
                          imagePath: 'assets/profile/referandearn.png',
                          icon: Icons.home,
                          text: 'Refer And Earn',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReferAndEarnPage()),
                            );
                          },
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        IconTextRow(
                          imagePath: 'assets/profile/directory.png',
                          icon: Icons.home,
                          text: 'Directory',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DirectoryPage()),
                            );
                          },
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        IconTextRow(
                          imagePath: 'assets/profile/terms.png',
                          icon: Icons.home,
                          text: 'Terms & Privacy',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsAndPrivacy()),
                            );
                          },
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        IconTextRow(
                          imagePath: 'assets/profile/logout.png',
                          icon: Icons.logout,
                          text: 'Logout',
                          onPressed: () async {
                            // await userPreference.signOut().then((value) {
                            //   context.go('/login');
                            // });
                          },
                        ),
                      ],
                    ),
                  )
                ])));
  }
}
