

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Models/User%20Creat%20Model/user_creat_model.dart';
import 'package:socialapp3/Moduels/User%20Profile/user_profile.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return ListView.separated(
          itemBuilder: (context, index) => userBuildItem(SocialCubit.get(context).users[index], context),
          separatorBuilder: (context, index) => newDivider(),
          itemCount: SocialCubit.get(context).users.length,
        );
      },
    );
  }
}

Widget userBuildItem(SocialUserModel userModel, context) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${userModel.image}',
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '${userModel.name}',
            style: const TextStyle(
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            width: 70,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: ColorApp.mainColor
            ),

              child: TextButton(
                  onPressed: ()
                  {
                    NavigatorTo(context, UsersProfile(userModel: userModel,));
                  },
                  child: Text(
                      'Profile',
                      style: TextStyle(
                        color: ColorApp.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
              ),
          ),
        ],
      ),
    );
