import 'package:Conversat/services/db.dart';
import 'package:Conversat/services/services.dart';

class Global {
  static final Map models = {
    User: (data) => User.fromMap(data),
    UserPublic: (data) => UserPublic.fromMap(data),
  };

  static final UserData<User> userRef = UserData<User>();
}