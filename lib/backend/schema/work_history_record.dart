import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'work_history_record.g.dart';

abstract class WorkHistoryRecord
    implements Built<WorkHistoryRecord, WorkHistoryRecordBuilder> {
  static Serializer<WorkHistoryRecord> get serializer =>
      _$workHistoryRecordSerializer;

  String? get jobTitle;

  String? get companyName;

  DateTime? get startDate;

  DateTime? get endDate;

  String? get jobDescription;

  DocumentReference? get user;

  String? get companyLogo;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(WorkHistoryRecordBuilder builder) => builder
    ..jobTitle = ''
    ..companyName = ''
    ..jobDescription = ''
    ..companyLogo = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('workHistory');

  static Stream<WorkHistoryRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<WorkHistoryRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  WorkHistoryRecord._();
  factory WorkHistoryRecord([void Function(WorkHistoryRecordBuilder) updates]) =
      _$WorkHistoryRecord;

  static WorkHistoryRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createWorkHistoryRecordData({
  String? jobTitle,
  String? companyName,
  DateTime? startDate,
  DateTime? endDate,
  String? jobDescription,
  DocumentReference? user,
  String? companyLogo,
}) {
  final firestoreData = serializers.toFirestore(
    WorkHistoryRecord.serializer,
    WorkHistoryRecord(
      (w) => w
        ..jobTitle = jobTitle
        ..companyName = companyName
        ..startDate = startDate
        ..endDate = endDate
        ..jobDescription = jobDescription
        ..user = user
        ..companyLogo = companyLogo,
    ),
  );

  return firestoreData;
}
