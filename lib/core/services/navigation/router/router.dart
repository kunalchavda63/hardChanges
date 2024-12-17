// Todo After Add Enum For Go Router


import '../router.dart';

final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
        name: "splash Screen",
        builder: (context,state){
            return SplashScreen();
        }

      ),
      GoRoute(
          path: '/home',
          name: "Home Screen",
          builder: (context,state){
            return HomeScreen();
          }
      ),


    ]
);