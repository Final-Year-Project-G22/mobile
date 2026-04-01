import 'package:flutter/material.dart';

class OAuthCallbackPage extends StatelessWidget {
  const OAuthCallbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Finishing sign in...'),
          ],
        ),
      ),
    );
  }
}
