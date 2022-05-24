import 'dart:math';

import 'package:flutter/material.dart';
import 'package:github_client/src/github_login.dart';
import 'package:github_client/src/github_summary.dart';
import 'package:window_to_front/window_to_front.dart';
import 'package:github/github.dart';

import 'github_oauth_credentials.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Github Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
        builder: (context, httpClient) {
          WindowToFront.activate();
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: GitHubSummary(
              gitHub: _getGitHub(httpClient.credentials.accessToken),
            ),
          );
        },
        githubClientId: githubClientId,
        githubClientSecret: githubClientSecret,
        githubScopes: githubScopes);
  }

  Future<CurrentUser> viewerDetail(String accessToken) async {
    final gitHub = GitHub(auth: Authentication.withToken(accessToken));
    return gitHub.users.getCurrentUser();
  }
}

GitHub _getGitHub(String accessToken) {
  return GitHub(auth: Authentication.withToken(accessToken));
}