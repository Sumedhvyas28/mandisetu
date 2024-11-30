import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/pages/notificaiton/notification_view.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:url_launcher/url_launcher.dart';


class LogoutHeader extends StatelessWidget {
  const LogoutHeader({super.key});

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
            },
            child: const Icon(
              Icons.logout,
              color: StyleConstants.darkDarkGreen,
              size: 25,
            ),
          ),

          const SizedBox(width: 15),

        ],
      ),
    );
  }
}
