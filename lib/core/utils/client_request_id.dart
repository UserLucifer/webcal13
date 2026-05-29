import 'package:uuid/uuid.dart';

class ClientRequestId {
  static const _uuid = Uuid();

  static String next() => _uuid.v4();
}
