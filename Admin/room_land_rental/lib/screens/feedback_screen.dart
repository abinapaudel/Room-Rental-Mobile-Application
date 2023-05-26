import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/controller/feedback_controller.dart';
import 'package:room_land_rental/model/feedback.dart' as fb;
import 'package:room_land_rental/widget/custom_appbar.dart';
import 'package:room_land_rental/widget/custom_drawer.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppbar(),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: GetBuilder<FeedbackController>(builder: (controller) {
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xff2b2b5f),
                  ),
                  child: Row(children: const [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'S.N',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 13,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 13,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Feedback',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 13,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ]),
                ),
                ...controller.feedbacks
                    .map((feed) => Slidable(
                          child: FeedbackTile(feed: feed),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (a) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Delete Feedback?'),
                                          content: const Text(
                                              'Are you sure you want to delete this feedback?'),
                                          actions: [
                                            ElevatedButton(
                                              child: const Text('Yes'),
                                              onPressed: () {
                                                controller.deleteFeedback(
                                                    feed.id, context);
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('No',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                backgroundColor: const Color(0xFFff0000),
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.trashAlt,
                                label: '',
                              ),
                            ],
                          ),
                        ))
                    .toList()
              ],
            );
          }),
        ));
  }
}

class FeedbackTile extends StatelessWidget {
  const FeedbackTile({Key? key, required this.feed}) : super(key: key);

  final fb.Feedback feed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Text(
            feed.id!,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            feed.name!,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              feed.feedback!,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            )),
      ]),
    );
  }
}
