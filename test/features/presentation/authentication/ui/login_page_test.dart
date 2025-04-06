import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:capstone_pawfund_app/features/presentation/authentication/ui/login_page.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sizer/sizer.dart';

import 'login_page_test.mocks.dart';

// Create a mock class for NavigatorObserver
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockDebugLogger extends Mock implements DebugLogger {
  // Định nghĩa phương thức printLog giả lập (mock) trong MockDebugLogger
  @override
  void printLog(String message) {
    // Không cần làm gì ở đây, vì mock chỉ cần theo dõi việc gọi phương thức này.
  }
}

// Create a mock class for Route
class MockRoute<T> extends Mock implements Route<T> {}

@GenerateMocks([AuthenticationBloc])
void main() {
  final testEmail = 'test@example.com';
  final testPassword = 'password123';

  testWidgets('Login button triggers authentication event',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: Sizer(
          builder: (context, orientation, deviceType) {
            return LoginPage(bloc: mockBloc);
          },
        ),
      ),
    );

    // Act
    await tester.enterText(find.byType(TextFormField).at(0), testEmail);
    await tester.enterText(find.byType(TextFormField).at(1), testPassword);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert
    final captured = verify(mockBloc.add(captureAny)).captured;
    final event = captured.first as AuthenticationLoginEvent;
    expect(event.email, testEmail);
    expect(event.password, testPassword);
  });

  testWidgets('email_is_prepopulated_when_widget_email_is_provided_1',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final prepopulatedEmail = 'prepopulated@example.com';

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(bloc: mockBloc, email: prepopulatedEmail),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    final emailField = find.byType(TextFormField).first;
    expect(tester.widget<TextFormField>(emailField).controller!.text,
        prepopulatedEmail);
  });

  testWidgets('valid_email_format_passes_validation',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final validEmail = 'user@domain.com';
    final testPassword = 'password123';

    await tester.pumpWidget(
      MaterialApp(
        home: Sizer(
          builder: (context, orientation, deviceType) {
            return LoginPage(bloc: mockBloc);
          },
        ),
      ),
    );

    // Act
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, validEmail);

    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, testPassword);

    await tester.pump();

    final loginButton = find.widgetWithText(ElevatedButton, 'Đăng nhập');
    await tester.tap(loginButton);
    await tester.pump();

    // Assert
    final captured = verify(mockBloc.add(captureAny)).captured;
    final event = captured.first as AuthenticationLoginEvent;
    expect(event.email, validEmail);
    expect(event.password, testPassword);
  });

  testWidgets('password_field_accepts_valid_password',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final testEmail = 'test@example.com';
    final validPassword = 'ValidPassword123';

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, testEmail);

    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, validPassword);

    await tester.pump();

    final loginButton = find.widgetWithText(ElevatedButton, 'Đăng nhập');
    await tester.tap(loginButton);
    await tester.pump();

    // Assert
    final captured = verify(mockBloc.add(captureAny)).captured;
    final event = captured.first as AuthenticationLoginEvent;
    expect(event.email, testEmail);
    expect(event.password, validPassword);
  });

  testWidgets(
      'login_button_triggers_authentication_event_with_valid_credentials',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final testEmail = 'valid@example.com';
    final testPassword = 'validPassword123';

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, testEmail);

    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, testPassword);

    await tester.pump();

    final loginButton = find.widgetWithText(ElevatedButton, 'Đăng nhập');
    await tester.tap(loginButton);
    await tester.pump();

    // Assert
    final captured = verify(mockBloc.add(captureAny)).captured;
    final event = captured.first as AuthenticationLoginEvent;
    expect(event.email, testEmail);
    expect(event.password, testPassword);
  });

  testWidgets('login_event_triggered_when_form_is_valid',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final testEmail = 'valid@example.com';
    final testPassword = 'validPassword123';

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, testEmail);

    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, testPassword);

    await tester.pump();

    final loginButton = find.widgetWithText(ElevatedButton, 'Đăng nhập');
    await tester.tap(loginButton);
    await tester.pump();

    // Assert
    final captured = verify(mockBloc.add(captureAny)).captured;
    final event = captured.first as AuthenticationLoginEvent;
    expect(event.email, testEmail);
    expect(event.password, testPassword);
  });

  testWidgets('email_is_prepopulated_when_widget_email_is_provided',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final prepopulatedEmail = 'prepopulated@example.com';

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(bloc: mockBloc, email: prepopulatedEmail),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    final emailField = find.byType(TextFormField).first;
    expect(tester.widget<TextFormField>(emailField).controller!.text,
        prepopulatedEmail);
  });

  testWidgets('form_renders_with_all_ui_elements', (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.text('ĐĂNG NHẬP'),
        findsOneWidget); // Kiểm tra nếu có text 'ĐĂNG NHẬP'
    expect(find.byType(TextFormField),
        findsNWidgets(2)); // Kiểm tra có đúng 2 TextFormField
    expect(find.widgetWithText(ElevatedButton, 'Đăng nhập'),
        findsOneWidget); // Kiểm tra nút 'Đăng nhập'
    expect(find.widgetWithText(TextButton, 'Đăng ký'),
        findsOneWidget); // Kiểm tra nút 'Đăng ký'
    expect(find.byIcon(Icons.arrow_back),
        findsOneWidget); // Kiểm tra icon mũi tên quay lại
    expect(find.byIcon(Icons.home), findsOneWidget); // Kiểm tra icon home
  });

  testWidgets('back_button_navigates_to_previous_screen',
      (WidgetTester tester) async {
    // Arrange
    final mockObserver = MockNavigatorObserver(); // Giả lập NavigatorObserver
    final mockRoute = MockRoute();
    Get.testMode = true;

    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(
            bloc: MockAuthenticationBloc(),
            email: null), // LoginPage là trang chính
        navigatorObservers: [
          mockObserver
        ], // Đảm bảo có observer cho việc điều hướng
      ),
    );

    // Act
    final backButton = find.byIcon(Icons.arrow_back); // Tìm nút quay lại
    await tester.tap(backButton); // Mô phỏng nhấn nút quay lại
    await tester.pumpAndSettle(); // Đảm bảo UI được cập nhật sau hành động

    // Assert
    expect(Get.currentRoute, equals('/'));
  });

  testWidgets('Empty email shows validation error',
      (WidgetTester tester) async {
    // Arrange: Tạo Mock cho AuthenticationBloc
    final mockBloc = MockAuthenticationBloc();

    // Tạo trang login với email rỗng
    final loginPage = LoginPage(bloc: mockBloc, email: '');

    final testWidget = GetMaterialApp(
      home: loginPage,
    );

    // Act: Render widget
    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    // Nhập mật khẩu hợp lệ
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    // Nhấn nút đăng nhập để kích hoạt validation
    await tester.tap(find.text('Đăng nhập').last);
    await tester.pump();

    // Assert: Kiểm tra lỗi xác nhận email
    expect(find.text('Vui lòng nhập email'), findsOneWidget);

    // Giả sử bạn có email và password hợp lệ
    final testEmail = 'test@example.com';
    final testPassword = 'password123';

// Khi email hợp lệ và password nhập vào hợp lệ
    await tester.enterText(find.byType(TextFormField).first, testEmail);
    await tester.enterText(find.byType(TextFormField).at(1), testPassword);
    await tester.tap(find.text('Đăng nhập').last);
    await tester.pump();

// Xác minh rằng sự kiện AuthenticationLoginEvent đã được gọi
    final captured2 = verify(mockBloc.add(captureAny)).captured;
    final event = captured2.first as AuthenticationLoginEvent;
    expect(event.email, testEmail);
    expect(event.password, testPassword);
  });

  testWidgets('invalid_email_shows_error_message', (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();

    // Sử dụng GetMaterialApp thay vì MaterialApp
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    // Tìm và điền email không hợp lệ vào trường email
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, 'invalid-email');

    // Đảm bảo widget được rebuild sau khi nhập văn bản
    await tester.pump();

    // Assert
    // Kiểm tra xem thông báo lỗi cho email không hợp lệ có xuất hiện không
    expect(find.text('Email không hợp lệ'), findsOneWidget);
  });

  testWidgets('empty_password_field_shows_validation_error',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final testEmail = 'test@example.com';

    await tester.pumpWidget(
      GetMaterialApp(
        // Dùng GetMaterialApp thay vì MaterialApp
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    // Tìm và điền email hợp lệ vào trường email
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, testEmail);

    // Để trường mật khẩu trống
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, '');

    // Đảm bảo widget được rebuild sau khi nhập văn bản
    await tester.pump();

    // Tìm và nhấn nút đăng nhập
    final loginButton = find.widgetWithText(ElevatedButton, 'Đăng nhập');
    await tester.tap(loginButton);

    // Đảm bảo mọi cập nhật UI hoàn tất
    await tester.pumpAndSettle();

    // Assert: Kiểm tra lỗi xác nhận mật khẩu
    expect(find.text('Vui lòng nhập mật khẩu '), findsOneWidget);
  });

  testWidgets('email_input_filters_special_characters',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();
    final testEmail = 'test@ex!ample.com';
    final expectedEmail = 'test@example.com'; // Email đã được lọc
    final testPassword = 'password123';

    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    // Find and fill the email field with special characters
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, testEmail);

    // Ensure the widget is rebuilt after text input
    await tester.pump();

    // Find and fill the password field
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, testPassword);

    // Find and tap the login button
    final loginButton = find.widgetWithText(ElevatedButton, 'Đăng nhập');
    await tester.tap(loginButton);
    await tester.pump();

    // Assert
    // Kiểm tra lại nếu sự kiện không được gọi
    verifyNever(mockBloc.add(AuthenticationLoginEvent(
      email: testEmail,
      password: testPassword,
    ))); // Đảm bảo rằng email chưa được gọi trước khi lọc
  });

  testWidgets(
      'login_button_does_not_trigger_authentication_event_when_form_is_invalid',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();

    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    // Find and fill the email field with invalid email
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, 'invalid-email');

    // Find and fill the password field with empty password
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, '');

    // Ensure the widget is rebuilt after text input
    await tester.pumpAndSettle(); // Ensures all state updates are applied

    // Find and tap the login button
    final loginButton = find.widgetWithText(ElevatedButton, 'Đăng nhập');
    await tester.tap(loginButton);
    await tester.pump();

    // Assert that the AuthenticationLoginEvent was NOT added to the mock bloc
    verifyNever(mockBloc.add(any)); // Verifies no event was added
  });

  testWidgets('ui_adapts_to_different_screen_sizes',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockAuthenticationBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(bloc: mockBloc, email: null),
      ),
    );

    // Act
    // Get the initial physical size of the screen
    final initialSize = tester.view.physicalSize;

    // Change the physical size for testing purposes
    tester.view.physicalSize = Size(800, 600);
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Reset the screen size to the initial size
    tester.view.physicalSize = initialSize;
  });
}
