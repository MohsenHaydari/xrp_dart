part of 'package:xrp_dart/src/xrpl/bytes/serializer.dart';

class Blob extends SerializedType {
  Blob([List<int>? buffer]) : super(buffer);

  @override
  factory Blob.fromParser(BinaryParser parser, [int? lengthHint]) {
    return Blob(parser.read(lengthHint!));
  }

  @override
  factory Blob.fromValue(String value) {
    List<int> bytes = [];
    try {
      bytes = BytesUtils.fromHexString(value);
    } catch (e) {
      bytes = StringUtils.encode(value);
    }
    return Blob(bytes);
  }
}
