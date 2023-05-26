import 'package:get/get.dart';
import 'package:rent_it_user/screens/Land/land_desc.dart';
import 'package:rent_it_user/screens/Land/land_screen.dart';
import 'package:rent_it_user/screens/about_screen.dart';
import 'package:rent_it_user/screens/auth/login.dart';
import 'package:rent_it_user/screens/auth/signup.dart';
import 'package:rent_it_user/screens/contact_screen.dart';
import 'package:rent_it_user/screens/help_screen.dart';
import 'package:rent_it_user/screens/home_screen.dart';
import 'package:rent_it_user/screens/request.dart';
import 'package:rent_it_user/screens/land/land_booking.dart';
import 'package:rent_it_user/screens/profile_screen.dart';
import 'package:rent_it_user/screens/room/room_booking.dart';
import 'package:rent_it_user/screens/room/room_desc.dart';
import 'package:rent_it_user/screens/room/room_screen.dart';
import 'package:rent_it_user/screens/send_feedback.dart';

class GetRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String roomScreen = '/roomScreen';
  static const String landScreen = '/landScreen';
  static const String roomDesc = '/roomDesc';
  static const String landDesc = '/landDesc';
  static const String myRequests = '/myRequests';
  static const String myRoomBookings = '/myRoomBookings';
  static const String myLandBookings = '/myLandBookings';
  static const String sendFeedback = '/sendFeedback';
  static const String invitations = '/invitations';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String help = '/help';

  static List<GetPage> routes = [
    GetPage(name: GetRoutes.login, page: () => Login()),
    GetPage(name: GetRoutes.signup, page: () => Signup()),
    GetPage(name: GetRoutes.home, page: () => HomeScreen()),
    GetPage(name: GetRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: GetRoutes.roomScreen, page: () => RoomScreen()),
    GetPage(name: GetRoutes.landScreen, page: () => LandScreen()),
    GetPage(name: GetRoutes.roomDesc, page: () => RoomDesc()),
    GetPage(name: GetRoutes.landDesc, page: () => LandDesc()),
    GetPage(name: GetRoutes.myRoomBookings, page: () => RoomBooking()),
    GetPage(name: GetRoutes.myLandBookings, page: () => const LandBooking()),
    GetPage(name: GetRoutes.sendFeedback, page: () => const SendFeedback()),
    GetPage(name: GetRoutes.invitations, page: () => const Invitations()),
    GetPage(name: GetRoutes.about, page: () => const AboutUs()),
    GetPage(name: GetRoutes.contact, page: () => const ContactUs()),
    GetPage(name: GetRoutes.help, page: () => const HelpScreen()),
  ];
}
