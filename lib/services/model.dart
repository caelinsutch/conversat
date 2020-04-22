///
/// User Model
/// Holds all attributes of the user in the database
///
class User {
  String uid; // UID linking to fireauth
  String name; // Display name taken from Google
  String userName; // Username that is displayed to other users
  String email; // Users email
  String bio; // A short bio that is shown on the userpage
  int followers; // How many followers a user has

  // Constructor for each user
  User({this.uid, this.name, this.email, this.bio, this.followers});

  // Used when creating a user class from a map
  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      bio: data['bio'] ?? '',
      followers: data['followers'] ?? 0,
    );
  }
}

///
/// Document for public data of a person
/// id of document is the uid of the user
///
class UserPublic {
  List<Question> questions; // List of users questions
  List<String> followers; // Followers of the user uid

  UserPublic({this.questions, this.followers});

  factory UserPublic.fromMap(Map data) {
    return UserPublic(
      questions: (data['questions'] as List ?? [])
          .map((e) => Question.fromMap(e))
          .toList(),
      followers: data['followers'] as List ?? []
    );
  }


}

///
/// A single question for a user
///
class Question {
  String question;
  String answer;

  Question({this.question, this.answer});

  factory Question.fromMap(Map data) {
    return Question(
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  }
}
