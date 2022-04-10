import 'package:belts_test/home/home_page.dart';
import 'package:belts_test/mars_floor/mars_floor_page.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static GoRouter getRoutes() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/mars_floor/:instruction',
          builder: (context, state) => MarsFloorPage(
            instruction: state.params['instruction']!,
          ),
        ),
      ],
    );
  }
}
