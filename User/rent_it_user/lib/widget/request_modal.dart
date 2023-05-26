import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/land_room_controller.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_textfield.dart';

class RequestModal extends StatelessWidget {
  const RequestModal({
    Key? key,
    required this.type,
    required this.title,
  }) : super(key: key);

  final String type;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandRoomController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Visit Request ',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const FaIcon(FontAwesomeIcons.xmark))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Type: $type',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Title: $title',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                  );
                  if (pickedDate != null) {
                    controller.selectedDate = pickedDate;
                    controller.update();
                  }
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: const Color(0xffa8a8a8))),
                      child: const Text(
                        'Select Date:',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.selectedDate.toString().split(" ")[0],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Message',
                controller: controller.messageController,
                maxLines: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onPressed: () {
                  controller.makeVisitRequest(type, title, context);
                },
                title: 'Request',
                fontSize: 13,
              )
            ],
          ),
        ),
      );
    });
  }
}
