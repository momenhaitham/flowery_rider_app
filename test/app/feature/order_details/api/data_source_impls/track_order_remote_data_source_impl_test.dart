import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/order_details/api/data_source_impls/track_order_remote_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/order_details/data/models/update_order_state_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([TrackOrderRemoteDataSourceImpl])
void main() {
  late TrackOrderRemoteDataSourceImpl trackOrderRemoteDataSourceImpl;

  setUpAll(() {
    trackOrderRemoteDataSourceImpl = MockTrackOrderRemoteDataSourceImpl();
    provideDummy<BaseResponse<UpdateOrderStateDto>>(SuccessResponse<UpdateOrderStateDto>(data: UpdateOrderStateDto()));
    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: "success"));
  });

  group("Testing update order state function", () {
    test("Testing update order state function with success response", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<UpdateOrderStateDto>(
            data: UpdateOrderStateDto(message: "Order state updated successfully")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<UpdateOrderStateDto>>());
      expect((response as SuccessResponse<UpdateOrderStateDto>).data.message, equals("Order state updated successfully"));
    });

    test("Testing update order state function with error response", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<UpdateOrderStateDto>(
            error: Exception("Failed to update order state")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<UpdateOrderStateDto>>());
      expect((response as ErrorResponse<UpdateOrderStateDto>).error, isA<Exception>());
    });

    test("Testing update order state function with null body", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderState(
        body: null,
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<UpdateOrderStateDto>(
            error: Exception("Body cannot be null")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderState(
        body: null,
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<UpdateOrderStateDto>>());
    });

    test("Testing update order state function with null orderId", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: null
      )).thenAnswer(
        (_) async {
          return ErrorResponse<UpdateOrderStateDto>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: null
      );

      expect(response, isA<ErrorResponse<UpdateOrderStateDto>>());
    });
  });

  group("Testing add new order document to firebase function", () {
    test("Testing add new order document to firebase with success response", () async {
      when(trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Order Accepted");
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<String>>());
      expect((response as SuccessResponse<String>).data, equals("Order Accepted"));
    });

    test("Testing add new order document to firebase with error response", () async {
      when(trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Failed to add order document")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
      expect((response as ErrorResponse<String>).error, isA<Exception>());
    });

    test("Testing add new order document to firebase with null body", () async {
      when(trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: null,
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be null")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: null,
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document to firebase with null orderId", () async {
      when(trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: null
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: null
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document to firebase with empty body", () async {
      when(trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be empty")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document to firebase with firebase exception", () async {
      when(trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Firebase error: Permission denied")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });
  });

  group("Testing update order state on firebase function", () {
    test("Testing update order state on firebase with success response", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Order State Updated");
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<String>>());
      expect((response as SuccessResponse<String>).data, equals("Order State Updated"));
    });

    test("Testing update order state on firebase with error response", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Failed to update order state on firebase")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
      expect((response as ErrorResponse<String>).error, isA<Exception>());
    });

    test("Testing update order state on firebase with null body", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: null,
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be null")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: null,
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing update order state on firebase with null orderId", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: null
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: null
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing update order state on firebase with empty body", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be empty")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing update order state on firebase with firebase exception", () async {
      when(trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Firebase error: Network error")
          );
        }
      );

      var response = await trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing update order state on firebase with different states", () async {
      final states = ["pending", "processing", "delivered", "cancelled"];
      
      for (String state in states) {
        when(trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
          body: {"state": state},
          orderId: "order123"
        )).thenAnswer(
          (_) async {
            return SuccessResponse<String>(data: "Order State Updated");
          }
        );

        var response = await trackOrderRemoteDataSourceImpl.updateOrderStateOnFirebase(
          body: {"state": state},
          orderId: "order123"
        );

        expect(response, isA<SuccessResponse<String>>());
      }
    });
  });
}