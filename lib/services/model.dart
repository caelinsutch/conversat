///
/// User Model
/// Holds all attributes of the user in the database
///
class User {
  String uid; // UID linking to fireauth
  String displayName; // Display name taken from Google
  String email; // Users email
  List<Notification> notifications;

  // Constructor for each user
  User({this.uid, this.displayName, this.email, this.notifications});

  // Used when creating a user class from a map
  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'] ?? '',
      displayName: data['name'] ?? '',
      email: data['email'] ?? '',
      notifications: (data['notifications'] as List ?? [])
        .map((e) => Notification.fromMap(e))
        .toList(),
    );
  }
}

///
/// Document for public data of a person
/// id of document is the uid of the user
///
class UserPublic {
  List<Question> questions; // List of users questions
  String username;
  String profilePhoto;
  String bio; // A short bio that is shown on the userpage
  List<String> followers; // Followers of the user uid

  UserPublic({this.questions, this.followers, this.username, this.profilePhoto, this.bio});

  factory UserPublic.fromMap(Map data) {
    return UserPublic(
      questions: (data['questions'] as List ?? [])
          .map((e) => Question.fromMap(e))
          .toList(),
      followers: (data['followers'] as List ?? []),
      bio: data['bio'] ?? '',
      username: data['username'] ?? '',
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

///
/// Individual Notifications for each users
///
class Notification {
  String title;
  String body;

  Notification({this.title, this.body});

  factory Notification.fromMap(Map data) {
    return Notification(
      title: data['title'] ?? '',
      body: data['answer'] ?? '',
    );
  }
}
