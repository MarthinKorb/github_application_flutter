import 'dart:convert';

import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';

class UserRepositories {
  String name;
  String fullName;
  UserResponse owner;
  int stargazersCount;
  String language;
  UserRepositories({
    this.name,
    this.fullName,
    this.owner,
    this.stargazersCount,
    this.language,
  });

  UserRepositories copyWith({
    String name,
    String fullName,
    UserResponse owner,
    int stargazersCount,
    String language,
  }) {
    return UserRepositories(
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      owner: owner ?? this.owner,
      stargazersCount: stargazersCount ?? this.stargazersCount,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'full_name': fullName,
      'owner': owner.toMap(),
      'stargazers_count': stargazersCount,
      'language': language,
    };
  }

  factory UserRepositories.fromMap(Map<String, dynamic> map) {
    return UserRepositories(
      name: map['name'],
      fullName: map['full_name'],
      owner: UserResponse.fromMap(map['owner']),
      stargazersCount: map['stargazers_count'],
      language: map['language'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRepositories.fromJson(String source) =>
      UserRepositories.fromMap(json.decode(source));
}
