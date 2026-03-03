import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/core/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getException', () {
    testWidgets('returns correct string for different exception types', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Test ConnectionError
              expect(
                getException(ConnectionError()),
                'connectionFailed',
              );

              // Test ServerError with message
              const message = 'Server error';
              expect(
                getException(ServerError(message: message)),
                message,
              );

              // Test ServerError without message
              expect(getException(ServerError()), '');

              // Test unknown exception
              expect(getException(Exception('test')), '');

              return Container();
            },
          ),
        ),
      );
    });
  });
}
