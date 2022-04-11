import 'package:belts_test/error_page/not_valid_instruction_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('NotValidInstructionPage', () {
    testWidgets('renders NotValidInstructionPage', (tester) async {
      await tester.pumpApp(const NotValidInstructionPage());
      expect(find.byType(NotValidInstructionPage), findsOneWidget);
    });
  });
}
