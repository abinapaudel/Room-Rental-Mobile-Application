import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/routes.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/widget/custom_button.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    Key? key,
    required this.onPressed,
    required this.rent,
    required this.desc,
    required this.image,
    required this.title,
    required this.onEditPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  final Function onPressed;
  final Function onEditPressed;
  final Function onDeletePressed;
  final String title;
  final String desc;
  final String rent;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xffffffff),
            boxShadow: const [
              BoxShadow(
                color: Color(0x60000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Image(
                  image: NetworkImage(baseurl + image),
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff000000),
                                  decoration: TextDecoration.underline,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              'Rs.$rent',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff000000),
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          desc,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CustomButton(
                              onPressed: () {
                                onEditPressed();
                              },
                              title: 'Edit',
                              fontSize: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                              onPressed: () {
                                onDeletePressed();
                              },
                              title: 'Delete',
                              fontSize: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ]),
      ),
    );
  }
}
