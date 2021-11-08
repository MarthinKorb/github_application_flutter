import 'dart:convert';

import 'package:github_application_flutter/modules/user/domain/models/user.dart';

class UserResponse extends User {
  String reposUrl;
  String eventsUrl;
  String name;
  String company;
  String location;
  String email;
  String bio;
  int publicRepos;
  int followers;
  int following;
  UserResponse({
    String login,
    String avatarUrl,
    String url,
    this.reposUrl,
    this.eventsUrl,
    this.name,
    this.company,
    this.location,
    this.email,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
  }) : super(
          url: url,
          avatarUrl: avatarUrl,
          login: login,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'avatar_url': avatarUrl,
      'repos_url': reposUrl,
      'events_url': eventsUrl,
      'name': name,
      'company': company,
      'location': location,
      'email': email,
      'bio': bio,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      url: map['url'],
      avatarUrl: map['avatar_url'],
      login: map['login'],
      reposUrl: map['repos_url'],
      eventsUrl: map['events_url'],
      name: map['name'],
      company: map['company'],
      location: map['location'],
      email: map['email'],
      bio: map['bio'],
      publicRepos: map['public_repos'],
      followers: map['followers'],
      following: map['following'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));
}
