import '../../Auth/login_screen.dart';
import '../../admin_screen/admin_approvaltask.dart';
import '../../admin_screen/admin_createtask.dart';
import '../../admin_screen/admin_dashboard.dart';
import '../../admin_screen/admin_profile.dart';
import 'package:flutter/material.dart';
import '../../user_screen/splash_screen.dart';
import 'admin_route.dart';

class AdminRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    debugPrint("=== Route requested: '${settings.name}' ===");
    // Flutter को implicit deep-link routing ले पठाएको raw URI route लाई ignore गर्नुहोस्
    if (settings.name != null && settings.name!.contains("code=")) {
      debugPrint("=== Ignoring auto-generated deep link route ===");
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SizedBox.shrink(),
        opaque: false,
        barrierColor: Colors.transparent,
      );
    }
    switch(settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
            builder: (_) => SplashScreen()
        );
      case Routes.adminDashboardScreen:
        return MaterialPageRoute(
            builder: (_) => AdminDashboard()
        );
      case Routes.adminProfileScreen:
        return MaterialPageRoute(
            builder: (_) =>AdminProfile()
        );
      case Routes.adminApprovalScreen:
        return MaterialPageRoute(
            builder: (_) =>AdminApprovalTask()
        );
      case Routes.adminCreateTaskScreen:
        return MaterialPageRoute(
            builder: (_) => AdminCreateTask()
        );
      default:
        return MaterialPageRoute(
            builder: (_) =>
            const Scaffold(
              body: Center(
                child: Text("Page Not Found"),
              ),
            ));
    }
  }
}