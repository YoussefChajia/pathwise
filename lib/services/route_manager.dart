import 'package:go_router/go_router.dart';
import 'package:pathwise/screens/homepage.dart';
import 'package:pathwise/screens/temp_result.dart';

class RouteManager {
  static final RouteManager _instance = RouteManager._internal();

  factory RouteManager() {
    return _instance;
  }

  RouteManager._internal();

  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) => const TempResultPage(),
      ),
      /* GoRoute(
        path: '/details/:id',
        builder: (context, state) {
          final id = state.params['id']!;
          return DetailsScreen(id: id);
        },
      ), */
    ],
  );

  void goToHome() => router.go('/');
  void goToResult() => router.go('/result');
  //void goToDetails(String id) => router.goNamed('details', params: {'id': id});
}
