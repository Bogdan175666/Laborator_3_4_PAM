import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/user.dart';

class UserProfile extends StatelessWidget {
  final User user;

  const UserProfile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //spatiu de sus

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Color(0xFF363062),
                  size: 16,
                ),
                Text(
                  user.location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
              ],
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF111827),
                fontWeight: FontWeight.bold,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            child: ClipOval(
              child: Image.asset(
                user.avatarUrl,
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            )),

        //alt cerc cu svg
      ],
    );
  }
}
