import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/pages/notificaiton/notification_view.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:url_launcher/url_launcher.dart';


class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: StyleConstants.darkGreen, width: 2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/mandisetu_logo.png',
              height: 28,
            ),

            const Spacer(),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, NamedRoutes.profile);
              },
              child: const Icon(
                CupertinoIcons.person_crop_circle_fill,
                color: StyleConstants.darkDarkGreen,
                size: 25,
              ),
            ),

            const SizedBox(width: 15),

            InkWell(
              onTap: (){
                // Navigator.pushNamed(context, NamedRoutes.profile);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationView(),));
              },
              child: const Stack(
                children: [
                  Icon(
                    Icons.notifications,
                    color: StyleConstants.darkDarkGreen,
                    size: 25,
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),

            // InkWell(
            //   onTap: (){
            //     final url = Uri.parse("whatsapp://send?phone=9827278310&text=Hello,%20I%20need%20help");
            //     _launchInWebView(url);
            //   },
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.call,
            //         color: StyleConstants.darkDarkGreen,
            //         size: 20,
            //       ),
            //       const SizedBox(width: 5),
            //       Text(
            //         'Help',
            //         style: Theme.of(context)
            //             .textTheme
            //             .bodyMedium!
            //             .copyWith(fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // ),

          ],
        ),
      );
  }
}
