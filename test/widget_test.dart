import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sumit/core/localization/app_strings.dart';
import 'package:sumit/feature/blinkit_money/presentation/screens/blinkit_money_screen.dart';
import 'package:sumit/feature/blinkit_money/presentation/view_models/blinkit_money_animation_view_model.dart';
import 'package:sumit/feature/blinkit_money/presentation/widgets/blinkit_money_widgets.dart';

void main() {
  final devices = <String, Size>{
    'small mobile': const Size(320, 568),
    'standard mobile': const Size(390, 844),
    'large mobile': const Size(430, 932),
    'tablet portrait': const Size(768, 1024),
  };

  for (final entry in devices.entries) {
    testWidgets('blinkit money fits ${entry.key}', (tester) async {
      tester.view.physicalSize = entry.value;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [AppStrings.delegate],
          supportedLocales: AppStrings.supportedLocales,
          home: BlinkitMoneyScreen(
            config: BlinkitMoneyIntroAnimationConfig(
              duration: Duration(milliseconds: 1000),
            ),
          ),
        ),
      );

      for (var elapsed = 0; elapsed <= 1000; elapsed += 100) {
        await tester.pump(Duration(milliseconds: elapsed == 0 ? 0 : 100));
        expect(tester.takeException(), isNull);
      }

      expect(find.byType(AddMoneyButton), findsOneWidget);
    });
  }
}
