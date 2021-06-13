import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'image_url')
  String get imageUrl;

  @nullable
  DocumentReference get user;

  @nullable
  int get price;

  @nullable
  String get description;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..imageUrl = ''
    ..price = 0
    ..description = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PostsRecord._();
  factory PostsRecord([void Function(PostsRecordBuilder) updates]) =
      _$PostsRecord;
}

Map<String, dynamic> createPostsRecordData({
  String imageUrl,
  DocumentReference user,
  int price,
  String description,
  DateTime createdAt,
}) =>
    serializers.toFirestore(
        PostsRecord.serializer,
        PostsRecord((p) => p
          ..imageUrl = imageUrl
          ..user = user
          ..price = price
          ..description = description
          ..createdAt = createdAt));

PostsRecord get dummyPostsRecord {
  final builder = PostsRecordBuilder()
    ..imageUrl = dummyImagePath
    ..price = dummyInteger
    ..description = dummyString
    ..createdAt = dummyTimestamp;
  return builder.build();
}

List<PostsRecord> createDummyPostsRecord({int count}) =>
    List.generate(count, (_) => dummyPostsRecord);
