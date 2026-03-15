import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../core/consts/app_consts.dart';
import '../domain/model/tracking_model.dart';
@singleton
class FirebaseTrackingManager {

  static CollectionReference<TrackingModel> getCollection()
  {
  return  FirebaseFirestore.instance.collection(AppConsts.orderCollection).
  withConverter<TrackingModel>(fromFirestore:(snapshot, options) {
  return TrackingModel.fromJson(snapshot.data()!);
  },
  toFirestore:(trackingModel, options) {
  return trackingModel.toJson();
  },
  );
  }
   Future<TrackingModel> getTrackingInfo(String trackingId)async
  {
    try {
      var document = await getCollection().doc(trackingId).get();

      return document.data()!;
    }on FirebaseException catch (e) {
      rethrow;
    }on Object catch (e,s) {
      print(e);
      print(s);
      rethrow;
    }

  }

  }
