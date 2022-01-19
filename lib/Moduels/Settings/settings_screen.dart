

import 'package:flutter/material.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:
        [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: ()
              {
                SocialCubit.get(context).signOut(context);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorApp.greyColor.withOpacity(0.2),
                ),

                height: 45,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Text(
                      'Sign Out',
                      style: TextStyle(
                          color: ColorApp.blackColor,
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
