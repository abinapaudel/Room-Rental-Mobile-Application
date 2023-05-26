import 'package:flutter/material.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_drawer.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar('About Us', true),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/property.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: -75,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Text(
                  'Rent It',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 10),
                const Text(
                  'This software allows you to search for both rooms and land. If you want to see rooms and land based on an address, we offer a search option that allows you to search in the appropriate location. Search makes it easy to see where a rental home, apartment, or piece of property is located.',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                const Text(
                  'There are further details about this app which is mention below.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You may see all of your rent history, as well as information like as when you booked this place',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                const Text(
                  'To visit the room or land that you like the best, you can send a visit request message.',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                const Text(
                  'If you wish to reserve a room or a plot of land, you may do so by paying a small amount of charge using the Khalti payment gateway.',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                const Text(
                  'If you like, you may update your profile details.',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                const Text(
                  'If you wish to cancel or delete a booked request, press on the booked information and then you can see the remove button. If you click on that, a dialog box will appear asking if you want to cancel the booking or not. If you wish to cancel the booking, use the ok button, and the booked room or land will be deleted.',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We loved if you helped to make our mobile application even more better.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'I am always looking for ways to improve my program, so if you have any experience with it, you may provide me feedback or make suggestions for future versions. For your proposal, there is a space for feedback. You may either go there and provide us feedback on our app or email us at abinapaudel10@gamil.com.',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
