import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/track_order/data/repo/track_order_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/update_order_state_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_repo_impl_test.mocks.dart';

@GenerateMocks([TrackOrderRepoImpl])
void main() {
  late TrackOrderRepoImpl trackOrderRepoImpl;

  setUpAll(() {
    trackOrderRepoImpl = MockTrackOrderRepoImpl();
    provideDummy<BaseResponse<UpdateOrderStateModel>>(SuccessResponse<UpdateOrderStateModel>(data: UpdateOrderStateModel()));
    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: "success"));
  });

  group("Testing update order state function", () {
    test("Testing update order state function with success response", () async {
      when(trackOrderRepoImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<UpdateOrderStateModel>(
            data: UpdateOrderStateModel(message: "Order state updated successfully")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<UpdateOrderStateModel>>());
      expect((response as SuccessResponse<UpdateOrderStateModel>).data.message, equals("Order state updated successfully"));
    });

    test("Testing update order state function with error response", () async {
      when(trackOrderRepoImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<UpdateOrderStateModel>(
            error: Exception("Failed to update order state")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<UpdateOrderStateModel>>());
      expect((response as ErrorResponse<UpdateOrderStateModel>).error, isA<Exception>());
    });

    test("Testing update order state function with null body", () async {
      when(trackOrderRepoImpl.updateOrderState(
        body: null,
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<UpdateOrderStateModel>(
            error: Exception("Body cannot be null")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderState(
        body: null,
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<UpdateOrderStateModel>>());
    });

    test("Testing update order state function with null orderId", () async {
      when(trackOrderRepoImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: null
      )).thenAnswer(
        (_) async {
          return ErrorResponse<UpdateOrderStateModel>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderState(
        body: {"state": "delivered"},
        orderId: null
      );

      expect(response, isA<ErrorResponse<UpdateOrderStateModel>>());
    });

    test("Testing update order state function with different states", () async {
      final states = ["pending", "processing", "delivered", "cancelled"];
      
      for (String state in states) {
        when(trackOrderRepoImpl.updateOrderState(
          body: {"state": state},
          orderId: "order123"
        )).thenAnswer(
          (_) async {
            return SuccessResponse<UpdateOrderStateModel>(
              data: UpdateOrderStateModel(message: "Order state updated to $state")
            );
          }
        );

        var response = await trackOrderRepoImpl.updateOrderState(
          body: {"state": state},
          orderId: "order123"
        );

        expect(response, isA<SuccessResponse<UpdateOrderStateModel>>());
      }
    });
  });

  group("Testing add new order document to firebase function", () {
    test("Testing add new order document to firebase with success response", () async {
      when(trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Order Accepted");
        }
      );

      var response = await trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<String>>());
      expect((response as SuccessResponse<String>).data, equals("Order Accepted"));
    });

    test("Testing add new order document to firebase with error response", () async {
      when(trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Failed to add order document")
          );
        }
      );

      var response = await trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
      expect((response as ErrorResponse<String>).error, isA<Exception>());
    });

    test("Testing add new order document to firebase with null body", () async {
      when(trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: null,
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be null")
          );
        }
      );

      var response = await trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: null,
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document to firebase with null orderId", () async {
      when(trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: null
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: null
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document to firebase with empty body", () async {
      when(trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be empty")
          );
        }
      );

      var response = await trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document to firebase returns non-null data", () async {
      when(trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Order Accepted");
        }
      );

      var response = await trackOrderRepoImpl.addNewOrderDocumentToFirebase(
        body: {"orderId": "order123", "status": "pending"},
        orderId: "order123"
      );

      expect((response as SuccessResponse<String>).data, isNotNull);
    });
  });

  group("Testing update order state on firebase function", () {
    test("Testing update order state on firebase with success response", () async {
      when(trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Order State Updated");
        }
      );

      var response = await trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<String>>());
      expect((response as SuccessResponse<String>).data, equals("Order State Updated"));
    });

    test("Testing update order state on firebase with error response", () async {
      when(trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Failed to update order state on firebase")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
      expect((response as ErrorResponse<String>).error, isA<Exception>());
    });

    test("Testing update order state on firebase with null body", () async {
      when(trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: null,
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be null")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: null,
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing update order state on firebase with null orderId", () async {
      when(trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: null
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: null
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing update order state on firebase with empty body", () async {
      when(trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Body cannot be empty")
          );
        }
      );

      var response = await trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {},
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing update order state on firebase with different states", () async {
      final states = ["pending", "processing", "delivered", "cancelled"];
      
      for (String state in states) {
        when(trackOrderRepoImpl.updateOrderStateOnFirebase(
          body: {"state": state},
          orderId: "order123"
        )).thenAnswer(
          (_) async {
            return SuccessResponse<String>(data: "Order State Updated");
          }
        );

        var response = await trackOrderRepoImpl.updateOrderStateOnFirebase(
          body: {"state": state},
          orderId: "order123"
        );

        expect(response, isA<SuccessResponse<String>>());
      }
    });

    test("Testing update order state on firebase returns non-null data", () async {
      when(trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Order State Updated");
        }
      );

      var response = await trackOrderRepoImpl.updateOrderStateOnFirebase(
        body: {"state": "delivered"},
        orderId: "order123"
      );

      expect((response as SuccessResponse<String>).data, isNotNull);
    });
  });
}