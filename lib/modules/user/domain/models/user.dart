import 'dart:convert';

class User {
  String login;
  String avatarUrl;
  String url;
  User({
    this.login,
    this.avatarUrl,
    this.url,
  });

  User copyWith({
    String login,
    String avatarUrl,
    String url,
  }) {
    return User(
      login: login ?? this.login,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'avatar_url': avatarUrl,
      'url': url,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      login: map['login'],
      avatarUrl: map['avatar_url'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(login: $login, avatar_url: $avatarUrl, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.login == login &&
        other.avatarUrl == avatarUrl &&
        other.url == url;
  }

  @override
  int get hashCode => login.hashCode ^ avatarUrl.hashCode ^ url.hashCode;
}
