import 'package:cloud_firestore/cloud_firestore.dart';

class UnitModel {
  String? uid;
  String? title;
  String? building;
  String? bik;
  String? street;
  String? unit;
  String? postalCode;
  String? rentalPrice;
  String? leaseStartDate;
  String? leaseEndDate;
  String? leasePeriod;
  String? dayRental;
  bool? parking;
  bool? wifi;
  bool? laundry;
  bool? pool;
  String? securityDeposit;
  String? remark;
  String? whatsup;
  String? status;
  List<dynamic>? rooms;
  List<dynamic>? images;
  List<dynamic>? tenants;

  UnitModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.get('uid') ?? '',
        title = snapshot.get('title') ?? '',
        building = snapshot.get('building') ?? '',
        bik = snapshot.get('bik') ?? '',
        street = snapshot.get('street') ?? '',
        unit = snapshot.get('unit') ?? '',
        postalCode = snapshot.get('postalCode') ?? '',
        rentalPrice = snapshot.get('rentalPrice') ?? '',
        leaseStartDate = snapshot.get('leaseStartDate') ?? '',
        leaseEndDate = snapshot.get('leaseEndDate') ?? '',
        leasePeriod = snapshot.get('leasePeriod') ?? '',
        dayRental = snapshot.get('dayRental') ?? '',
        parking = snapshot.get('parking') ?? '',
        wifi = snapshot.get('wifi') ?? '',
        laundry = snapshot.get('laundry') ?? '',
        pool = snapshot.get('pool') ?? '',
        remark = snapshot.get('remark') ?? '',
        securityDeposit = snapshot.get('securityDeposit') ?? '',
        whatsup = snapshot.get('whatsapp') ?? '',
        status = snapshot.get('status') ?? '',
        rooms = snapshot.get('rooms') ?? [],
        images = snapshot.get('images') ?? [],
        tenants = snapshot.get('tenants') ?? [];
}
