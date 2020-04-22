import 'package:Conversat/services/services.dart';

class Global {
  static final Map models = {
    User: (data) => User.fromMap(data),
  };
}