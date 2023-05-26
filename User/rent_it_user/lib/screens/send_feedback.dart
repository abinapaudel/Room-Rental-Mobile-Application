import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/feedback_controller.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_drawer.dart';
import 'package:rent_it_user/widget/custom_textfield.dart';

class SendFeedback extends StatelessWidget {
  const SendFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar('Feedback', true),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<FeedbackController>(builder: (controller) {
          return Column(
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
              const SizedBox(
                height: 100,
              ),
              const Text(
                'If you have any feedback about the app or suggestion, let us know',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Write your feedback here!',
                controller: controller.messageController,
                maxLines: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {
                  controller.sendFeedback();
                },
                title: 'Send',
                fontSize: 15,
              )
            ],
          );
        }),
      ),
    );
  }
}
