import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'applied_jobs_record.g.dart';

abstract class AppliedJobsRecord
    implements Built<AppliedJobsRecord, AppliedJobsRecordBuilder> {
  static Serializer<AppliedJobsRecord> get serializer =>
      _$appliedJobsRecordSerializer;

  DocumentReference? get jobApplied;

  DocumentReference? get userApplied;

  DateTime? get appliedTime;

  String? get coverLetter;

  @BuiltValueField(wireName: 'image_1')
  String? get image1;

  @BuiltValueField(wireName: 'image_2')
  String? get image2;

  @BuiltValueField(wireName: 'image_3')
  String? get image3;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(AppliedJobsRecordBuilder builder) => builder
    ..coverLetter = ''
    ..image1 = ''
    ..image2 = ''
    ..image3 = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('appliedJobs');

  static Stream<AppliedJobsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<AppliedJobsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  AppliedJobsRecord._();
  factory AppliedJobsRecord([void Function(AppliedJobsRecordBuilder) updates]) =
      _$AppliedJobsRecord;

  static AppliedJobsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createAppliedJobsRecordData({
  DocumentReference? jobApplied,
  DocumentReference? userApplied,
  DateTime? appliedTime,
  String? coverLetter,
  String? image1,
  String? image2,
  String? image3,
}) {
  final firestoreData = serializers.toFirestore(
    AppliedJobsRecord.serializer,
    AppliedJobsRecord(
      (a) => a
        ..jobApplied = jobApplied
        ..userApplied = userApplied
        ..appliedTime = appliedTime
        ..coverLetter = coverLetter
        ..image1 = image1
        ..image2 = image2
        ..image3 = image3,
    ),
  );

  return firestoreData;
}
