import 'package:belts_test/error_page/not_found_page.dart';
import 'package:belts_test/error_page/not_valid_instruction_page.dart';
import 'package:belts_test/helpers/utils.dart';
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
          builder: (context, state) {
            if (state.params['instruction'] == null ||
                !Utils.isInstructionIsValid(state.params['instruction']!) ||
                state.params['instruction']!.length > 9) {
              return const NotValidInstructionPage();
            }
            return MarsFloorPage(
              instruction: state.params['instruction']!,
            );
          },
        ),
      ],
      errorBuilder: (context, state) => const NotFoundPage(),
    );
  }
}
