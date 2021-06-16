import 'package:uuid/uuid.dart';

var uuid1 = Uuid().v1();
var uuid4 = Uuid().v4();
var uuid5 = Uuid().v5(Uuid.NAMESPACE_URL, 'www.google.com');
