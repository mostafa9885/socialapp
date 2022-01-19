
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Models/User%20Creat%20Model/user_creat_model.dart';
import 'package:socialapp3/Moduels/Chat%20Detiels/chat_detials_screen.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return ListView.separated(
          itemBuilder: (context, index) => chatBuildItem(SocialCubit.get(context).users[index], context),
          separatorBuilder: (context, index) => newDivider(),
          itemCount: SocialCubit.get(context).users.length,
        );
      },
    );
  }
}

Widget chatBuildItem(SocialUserModel userModel, context) =>
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
            height: 40,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorApp.mainColor
            ),
            child: IconButton(
              onPressed: ()
              {
                NavigatorTo(context, ChatDetailsScreen(userModel: userModel,));
              },
              icon: Icon(
                IconBroken.chat,
                color: ColorApp.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
