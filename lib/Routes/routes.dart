
import 'package:carpooling/Screens/com_ride/commuterride.dart';
import 'package:carpooling/Screens/com_ride/droplocation.dart';
import 'package:carpooling/Screens/com_ride/currentloc.dart';
import 'package:carpooling/Screens/com_ride/scheduleride.dart';
import 'package:carpooling/Screens/com_ride/searchresults.dart';
import 'package:carpooling/Screens/home_commuter/homecommuter.dart';
import 'package:carpooling/Screens/home_vehicle/home.dart';
import 'package:carpooling/Screens/profile/changepassword.dart';
import 'package:carpooling/Screens/profile/profile.dart';
import 'package:carpooling/Screens/profile/vehicledetails.dart';
import 'package:carpooling/Screens/register/otp.dart';
import 'package:carpooling/Screens/role_select/role_select.dart';
import 'package:carpooling/Screens/signin/forgetpassword/mail.dart';
import 'package:carpooling/Screens/signin/forgetpassword/otp.dart';
import 'package:carpooling/Screens/signin/forgetpassword/setpassword.dart';
import 'package:carpooling/Screens/signin/signin.dart';
import 'package:carpooling/Screens/splash/splash.dart';
import 'package:carpooling/Screens/veh_dashboard/dashboard.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/map.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/owner_dashboard.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/shcedule_ride.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/timeslot.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/via_points.dart';
import 'package:flutter/material.dart';
import 'package:carpooling/Screens/register/register.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
   switch (settings.name) {
     case '/splash':
       return MaterialPageRoute(builder: (context) => Splash());
     case '/signin':
       return MaterialPageRoute(builder: (context) => Signin());
      case '/register':
        return MaterialPageRoute(builder: (context) => Register());
      case '/registerotp':
        return MaterialPageRoute(builder: (context) => Registerotp());
     case '/forgetpassword':
       return MaterialPageRoute(builder: (_) => Forgetpassword());
     case '/passwordotp':
       return MaterialPageRoute(builder: (_) => Passwordotp());
     case '/setpassword':
       return MaterialPageRoute(builder: (_) => Setpassword());
     case '/Role':
       return MaterialPageRoute(builder: (_) => Role());
     case '/homecommuter':
       return MaterialPageRoute(builder: (_) =>Homecommuter());
     case '/home':
       return MaterialPageRoute(builder: (_) =>Home());
     case '/changepassword':
       return MaterialPageRoute(builder: (_) =>Changepassword());
     case '/profile':
       return MaterialPageRoute(builder: (_) =>Profile());
     case '/vehicledetails':
       return MaterialPageRoute(builder: (_) =>Vehicledetails());
     case '/dashboard':
       return MaterialPageRoute(builder: (_) =>Dashboard());
     case '/vehdashboard':
       return MaterialPageRoute(builder: (_) => Ownerdashboard());




     case '/pickuplocation':
       return MaterialPageRoute(builder: (_) =>Pickuplocation());
     case '/droplocation':
       return MaterialPageRoute(builder: (_) =>Droplocation());
     case '/scheduleride':
       return MaterialPageRoute(builder: (_) =>Commuterscheduleride());
     case '/searchresults':
       return MaterialPageRoute(builder: (_) =>Searchresults());
     case '/scheduleridevehicleowner':
       return MaterialPageRoute(builder: (_) =>Shceduleride());
     case '/viapoints':
       return MaterialPageRoute(builder: (_) =>Viapoint());
     case '/commuterride':
       return MaterialPageRoute(builder: (_) =>Commuterride());
     case '/timeslot':
       return MaterialPageRoute(builder: (_) =>Timeslot());
     case '/mapapp':
       return MaterialPageRoute(builder: (_) =>Mapapp());





   }
  }}
