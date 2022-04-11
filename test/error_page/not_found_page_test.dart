import 'package:belts_test/error_page/not_found_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('NotFoundPage', () {
    testWidgets('renders NotFoundPage', (tester) async {
      await tester.pumpApp(const NotFoundPage());
      expect(find.byType(NotFoundPage), findsOneWidget);
    });
  });
}
