import 'package:flutter/material.dart';

import '../../../widgets/custom_profile.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            Custom_Profile(),

          ],
        ),
      ),
    );
  }
}
