import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'companies_record.g.dart';

abstract class CompaniesRecord
    implements Built<CompaniesRecord, CompaniesRecordBuilder> {
  static Serializer<CompaniesRecord> get serializer =>
      _$companiesRecordSerializer;

  String? get companyName;

  String? get companyLogo;

  String? get companyHero;

  String? get companyDescription;

  LatLng? get companyLocation;

  String? get companyCity;

  String? get companyWebSite;

  String? get companySize;

  DocumentReference? get employees;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(CompaniesRecordBuilder builder) => builder
    ..companyName = ''
    ..companyLogo = ''
    ..companyHero = ''
    ..companyDescription = ''
    ..companyCity = ''
    ..companyWebSite = ''
    ..companySize = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('companies');

  static Stream<CompaniesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<CompaniesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  CompaniesRecord._();
  factory CompaniesRecord([void Function(CompaniesRecordBuilder) updates]) =
      _$CompaniesRecord;

  static CompaniesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createCompaniesRecordData({
  String? companyName,
  String? companyLogo,
  String? companyHero,
  String? companyDescription,
  LatLng? companyLocation,
  String? companyCity,
  String? companyWebSite,
  String? companySize,
  DocumentReference? employees,
}) {
  final firestoreData = serializers.toFirestore(
    CompaniesRecord.serializer,
    CompaniesRecord(
      (c) => c
        ..companyName = companyName
        ..companyLogo = companyLogo
        ..companyHero = companyHero
        ..companyDescription = companyDescription
        ..companyLocation = companyLocation
        ..companyCity = companyCity
        ..companyWebSite = companyWebSite
        ..companySize = companySize
        ..employees = employees,
    ),
  );

  return firestoreData;
}
