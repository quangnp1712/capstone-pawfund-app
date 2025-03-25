import 'package:capstone_pawfund_app/features/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/home_page/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  group('HomePage Widget Test', () {
    //? HAPPY PATH
    // Renders a Scaffold with SingleChildScrollView containing all UI sections
    testWidgets('build renders scaffold with all UI sections',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomePageBloc>(
            create: (context) => HomePageBloc(),
            child: HomePage(() {}),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Verify header section
      expect(find.text('Đăng nhập'), findsOneWidget);
      expect(
          find.image(AssetImage('assets/images/logo_1.png')), findsOneWidget);

      // Verify pet category section
      expect(find.text('Loại thú cưng nhận nuôi'), findsOneWidget);
      expect(find.byType(ListView), findsNWidgets(4));
      expect(find.text('Mèo'), findsWidgets);

      // Verify pet adoption section
      expect(find.text('Nhận nuôi thú cưng'), findsOneWidget);
      expect(find.text('Nguyễn Tiến Dũng'), findsWidgets);

      // Verify SOS banner
      expect(find.text('SOS: Chạm gọi - chúng tôi sẵn sàng!'), findsOneWidget);
      expect(find.text('CỨU HỘ NGAY >>'), findsOneWidget);

      // Verify support fund section
      expect(find.text('Quỹ hỗ trợ'), findsOneWidget);
      expect(find.text('ỦNG HỘ NGAY'), findsWidgets);

      // Verify rescue center section
      expect(find.text('Trung tâm cứu trợ'), findsOneWidget);
      expect(find.text('XEM THÊM'), findsWidgets);
    });

    // Correctly displays the header with logo and login button
    testWidgets('correctly_displays_header_with_logo_and_login_button',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => HomePageBloc(),
            child: HomePage(() {}),
          ),
        ),
      );

      // Act - widget is already built during pump

      // Assert
      expect(find.byType(Container), findsWidgets);
      expect(find.text('Đăng nhập'), findsOneWidget);
      expect(
          find.image(AssetImage('assets/images/logo_1.png')), findsOneWidget);
    });

    //? EDGE CASE
    // Handles different screen sizes through MediaQuery.of(context).size
    testWidgets('build adapts to different screen sizes',
        (WidgetTester tester) async {
      // Arrange - small screen size
      tester.binding.window.physicalSizeTestValue =
          Size(320, 480) * tester.binding.window.devicePixelRatio;
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => HomePageBloc(),
            child: HomePage(() {}),
          ),
        ),
      );

      // Verify SOS banner button width is proportional to screen size
      final smallScreenButton = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.text('CỨU HỘ NGAY >>'),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      final smallScreenWidth = smallScreenButton.width;

      // Verify support fund card width is proportional to screen size
      final smallScreenCard = tester.widget<Container>(
        find
            .ancestor(
              of: find.text('ỦNG HỘ NGAY').first,
              matching: find.byType(Container),
            )
            .first,
      );
      final smallScreenCardWidth = smallScreenCard.constraints?.maxWidth ?? 0;

      // Reset for large screen test
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();

      // Arrange - large screen size
      tester.binding.window.physicalSizeTestValue =
          Size(1080, 1920) * tester.binding.window.devicePixelRatio;
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => HomePageBloc(),
            child: HomePage(() {}),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify SOS banner button width is proportional to screen size
      final largeScreenButton = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.text('CỨU HỘ NGAY >>'),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      final largeScreenWidth = largeScreenButton.width;

      // Verify support fund card width is proportional to screen size
      final largeScreenCard = tester.widget<Container>(
        find
            .ancestor(
              of: find.text('ỦNG HỘ NGAY').first,
              matching: find.byType(Container),
            )
            .first,
      );
      final largeScreenCardWidth = largeScreenCard.constraints?.maxWidth ?? 0;

      // Assert that sizes are different and proportional
      expect(largeScreenWidth, greaterThan(smallScreenWidth as Object));
      expect(largeScreenCardWidth, greaterThan(smallScreenCardWidth));

      // Reset window size after test
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    //? OTHER
  });
}
