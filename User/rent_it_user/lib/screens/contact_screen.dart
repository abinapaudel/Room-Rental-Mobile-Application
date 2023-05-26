import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar('Contact Us', true),
        drawer: CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Text(
              'We are here to help you. If you have any questions, please feel free to contact us.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.toNamed(GetRoutes.about);
              },
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 75,
                    width: 75,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Rent It',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.locationDot),
                const SizedBox(width: 10),
                Text(
                  'Pokhara, Simalchar, Nepal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.envelope),
                const SizedBox(width: 10),
                Text(
                  'abinapaudel10@gmail.com',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.globe),
                const SizedBox(width: 10),
                Text(
                  'rentit.com.np',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.phone),
                const SizedBox(width: 10),
                Text(
                  '+977 9805897886',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Expanded(child: Text('')),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CustomButton(
                onPressed: () async {
                  String url = "tel:+9779805897886";
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                title: 'Call',
                fontSize: 15,
              ),
              CustomButton(
                onPressed: () async {
                  String url =
                      "mailto:abinapaudel10@gmail.com?subject=Jobs&body=Hello,";
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                title: 'Email',
                fontSize: 15,
              )
            ]),
          ]),
        ));
  }
}
