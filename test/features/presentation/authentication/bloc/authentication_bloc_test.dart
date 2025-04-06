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

import 'authentication_bloc_test.mocks.dart';

// Create a mock class for NavigatorObserver
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// Create a mock class for Route
class MockRoute<T> extends Mock implements Route<T> {}

@GenerateMocks([AuthenticationBloc])
void main() {
  test('initial event emits ShowLoginPageState', () async {
    // Arrange
    final mockBloc = MockAuthenticationBloc(); // Use the generated mock class

    // Mock the initial event behavior
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
          ShowLoginPageState(), // The expected state after initial event
        ]));

    // Act
    mockBloc.add(AuthenticationInitialEvent()); // Add the event to the Bloc

    // Assert
    await expectLater(
      mockBloc.stream,
      emits(isA<
          ShowLoginPageState>()), // Expect that the stream emits the ShowLoginPageState
    );
  });
}
