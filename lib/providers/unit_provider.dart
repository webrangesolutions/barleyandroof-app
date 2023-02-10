import 'dart:io';

import 'package:barleryroof/models/booking_model.dart';
import 'package:barleryroof/models/payment_model.dart';
import 'package:flutter/widgets.dart';

import '../constant.dart';
import '../models/unit_model.dart';

class UnitProvider extends ChangeNotifier {
  UnitModel? unit;
  List<UnitModel> unitList = [];
  List<BookingModel> bookingList = [];
  List<PaymentModel> paymentsList = [];

  Future fetchAllUnits() async {
    var msg = await service.fetchDocuments('Units');

    if (unitList.isNotEmpty) {
      unitList.clear();
      msg.docs.forEach((doc) {
        UnitModel u = UnitModel.fromSnapshot(doc);
        unitList.add(u);
        notifyListeners();
      });
    } else {
      msg.docs.forEach((doc) {
        UnitModel u = UnitModel.fromSnapshot(doc);
        unitList.add(u);
        notifyListeners();
      });
    }
  }

  Future fetchAllBookings() async {
    var msg = await service.fetchDocuments('Bookings');

    if (bookingList.isNotEmpty) {
      bookingList.clear();
      msg.docs.forEach((doc) {
        BookingModel b = BookingModel.fromSnapshot(doc);
        bookingList.add(b);
        notifyListeners();
      });
    } else {
      msg.docs.forEach((doc) {
        BookingModel b = BookingModel.fromSnapshot(doc);
        bookingList.add(b);
        notifyListeners();
      });
    }
  }

  Future fetchAllPayments() async {
    var msg = await service.fetchDocuments('Payments');

    if (paymentsList.isNotEmpty) {
      paymentsList.clear();
      msg.docs.forEach((doc) {
        PaymentModel p = PaymentModel.fromSnapshot(doc);
        paymentsList.add(p);
        notifyListeners();
      });
    } else {
      msg.docs.forEach((doc) {
        PaymentModel p = PaymentModel.fromSnapshot(doc);
        paymentsList.add(p);
        notifyListeners();
      });
    }
  }

  Future postUnit(data) async {
    var msg = await service.postDocumentWithId(data['uid'], 'Units', data);
    if(msg['success'] == true){
      await fetchAllUnits();
    }
    return msg;
  }

  Future postPayments(data) async {
    var msg = await service.postDocumentWithId(data['uid'], 'Payments', data);
    if(msg['success'] == true){
      await fetchAllPayments();
    }
    return msg;
  }

  Future postUnitBooking(data) async {
    var msg = await service.postDocumentWithId(data['uid'], 'Bookings', data);
    if(msg['success'] == true){
      await fetchAllBookings();
    }
    return msg;
  }

  Future updateUnit(uid, data) async {
    var msg = await service.updateDocument(uid, 'Units', data);
    if(msg['success'] == true){
      await fetchAllUnits();
    }
    return msg;
  }

  Future updateBooking(uid, data) async {
    var msg = await service.updateDocument(uid, 'Bookings', data);
    if(msg['success'] == true){
      await fetchAllBookings();
    }
    return msg;
  }

  Future<String> postUnitStorage(dir, data) async {
    var msg = await service.postStorage(dir, data);
    return msg;
  }
}
