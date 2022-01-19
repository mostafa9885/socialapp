

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Models/Message%20Model/message_model.dart';
import 'package:socialapp3/Models/User%20Creat%20Model/user_creat_model.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel? userModel;
  ChatDetailsScreen({this.userModel});

  var sendMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {

        SocialCubit.get(context).getMessages(receiverId: userModel!.uId.toString());

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state){},
          builder: (context, state)
          {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    const SizedBox(width: 10),
                    Text('${userModel!.name}'),
                  ],
                ),
                titleSpacing: 0,
                leading: IconButton(
                  icon: const Icon(IconBroken.arrowLeft2),
                  onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index)
                        {
                          var messages = SocialCubit.get(context).messages[index];

                          if(SocialCubit.get(context).model!.uId == messages.senderId)
                          {
                            return buildMyMessage(messages);
                          }
                          return buildMessage(messages);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorApp.greyColor.withOpacity(0.4),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children:
                        [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                controller: sendMessageController,
                                decoration: const InputDecoration(
                                  hintText: 'type your message here..',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            color: ColorApp.mainColor,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).sendMessage(
                                  text: sendMessageController.text,
                                  receiverId: userModel!.uId.toString(),
                                  dateTime: DateTime.now().toString(),
                                );
                              },
                              child: Icon(
                                IconBroken.send,
                                size: 19,
                                color: ColorApp.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              );
          },
        );
      },
    );
  }
}

Widget buildMessage(MessageModel model) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    decoration:BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        )
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: Text(
      '${model.text}',
    ),
  ),
);

Widget buildMyMessage(MessageModel model) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    decoration:BoxDecoration(
        color: ColorApp.mainColor.withOpacity(0.2),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        )
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: Text(
      '${model.text}',
    ),
  ),
);
