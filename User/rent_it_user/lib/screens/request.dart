import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/request_controller.dart';
import 'package:rent_it_user/model/request.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_drawer.dart';

class Invitations extends StatelessWidget {
  const Invitations({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar('Invitations', true),
      drawer: CustomDrawer(),
      body: GetBuilder<RequestController>(builder: (controller) {
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: controller.requests
                .map((req) => VisitRequestTile(req: req))
                .toList(),
          ),
        ));
      }),
    );
  }
}

class VisitRequestTile extends StatelessWidget {
  const VisitRequestTile({
    Key? key,
    required this.req,
  }) : super(key: key);

  final Request req;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xff000000)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RequestDescRow(
            title: 'Type:',
            value: req.type!,
            uppercase: true,
          ),
          const SizedBox(height: 10),
          RequestDescRow(
            title: 'Requested By:',
            value: req.name!,
          ),
          const SizedBox(height: 10),
          RequestDescRow(
            title: 'Rent Title:',
            value: req.title!,
          ),
          const SizedBox(height: 10),
          RequestDescRow(
            title: 'Date: ',
            value: req.date!,
          ),
          const SizedBox(height: 10),
          RequestDescRow(
            title: 'Message: ',
            value: req.message!,
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: () {
              showDialog(
                  context: (context),
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Remove'),
                      content: const Text(
                          'Are you sure you want to remove this request?'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Cancel'),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.deleteRequest(req.id, context);
                            Get.back();
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  });
            },
            title: 'Remove',
            fontSize: 12,
          )
        ]),
      );
    });
  }
}

class RequestDescRow extends StatelessWidget {
  const RequestDescRow({
    Key? key,
    this.title = "",
    this.value = "",
    this.uppercase = false,
  }) : super(key: key);
  final String title;
  final String value;
  final bool uppercase;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            uppercase ? value.toUpperCase() : value,
            style: const TextStyle(
                fontSize: 18,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
