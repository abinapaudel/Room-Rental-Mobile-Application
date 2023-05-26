import 'package:get/get.dart';
import 'package:room_land_rental/screens/add_land.dart';
import 'package:room_land_rental/screens/add_room.dart';
import 'package:room_land_rental/screens/feedback_screen.dart';
import 'package:room_land_rental/screens/home_screen.dart';
import 'package:room_land_rental/screens/land_booking.dart';
import 'package:room_land_rental/screens/land_desc.dart';
import 'package:room_land_rental/screens/login_screen.dart';
import 'package:room_land_rental/screens/room_booking.dart';
import 'package:room_land_rental/screens/room_desc.dart';
import 'package:room_land_rental/screens/users_screen.dart';
import 'package:room_land_rental/screens/visit_request_screen.dart';

class GetRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String roomDesc = '/room-desc';
  static const String landDesc = '/land-desc';
  static const String addRoom = '/add-room';
  static const String addLand = '/add-land';
  static const String users = '/users';
  static const String feedback = '/feedback';
  static const String visitRequest = '/visitRequest';
  static const String roomBooking = '/roomBooking';
  static const String landBooking = '/landBooking';

  static List<GetPage> routes = [
    GetPage(name: GetRoutes.login, page: () => LoginScreen()),
    GetPage(name: GetRoutes.home, page: () => HomeScreen()),
    GetPage(name: GetRoutes.roomDesc, page: () => RoomDesc()),
    GetPage(name: GetRoutes.landDesc, page: () => LandDesc()),
    GetPage(name: GetRoutes.addRoom, page: () => AddRoom()),
    GetPage(name: GetRoutes.users, page: () => const UserScreen()),
    GetPage(name: GetRoutes.addLand, page: () => AddLand()),
    GetPage(name: GetRoutes.feedback, page: () => const FeedbackScreen()),
    GetPage(
        name: GetRoutes.visitRequest, page: () => const VisitRequestScreen()),
    GetPage(name: GetRoutes.roomBooking, page: () => RoomBooking()),
    GetPage(name: GetRoutes.landBooking, page: () => const LandBooking()),
  ];
}
