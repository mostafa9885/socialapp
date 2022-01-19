

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Models/User%20Creat%20Model/user_creat_model.dart';
import 'package:socialapp3/Moduels/Chat%20Detiels/chat_detials_screen.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Components/constant.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class UsersProfile extends StatelessWidget {

  int x = 30;

  SocialUserModel? userModel;
  UsersProfile({this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {

        SocialCubit.get(context).getUserProfileData(userId: userModel!.uId.toString());

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state){},
          builder: (context, state)
          {

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(IconBroken.arrowLeft2),
                  onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0,
                title: const Text(
                    'Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children:
                    [
                      Container(
                        height: 250,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children:
                          [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            '${userModel?.cover}',
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 63,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    backgroundImage: NetworkImage(
                                      '${userModel?.image}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${userModel?.name}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${userModel!.bio}',
                        style: caption(context)!.copyWith(
                          color: ColorApp.blackColor,
                          fontSize: 15,
                          fontFamily: 'Quicksand',
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children:
                        [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const
                                [
                                  Text(
                                    '7',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    'Post',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const
                                [
                                  Text(
                                    '11',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    'Photo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const
                                [
                                  Text(
                                    '1.7M',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    'Flowers',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const
                                [
                                  Text(
                                    '7',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children:
                        [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(1.8),
                              ),
                              onPressed: (){},
                              icon: const Icon(IconBroken.addUser),
                              label: const Text('Add Friend'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(1.8),
                              ),
                              onPressed: ()
                              {
                                NavigatorTo(context, ChatDetailsScreen(userModel: userModel,));
                              },
                              icon: const Icon(IconBroken.chat),
                              label: const Text('Message'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(1.8),
                            ),
                            onPressed: ()
                            {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )
                                  ),
                                  context: context,
                                  builder: (_) => Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children:
                                      [
                                        InkWell(
                                          onTap: ()
                                          {
                                            //NavigatorTo(context, EditInformationScreen());
                                          },
                                          child: Row(
                                            children:
                                            [
                                              CircleAvatar(
                                                radius: 18,
                                                backgroundColor: ColorApp.greyColor.withOpacity(0.3),
                                                child: const Icon(IconBroken.user),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Personal Information',
                                                style: TextStyle(
                                                    fontFamily: 'Quicksand',
                                                    color: ColorApp.blackColor,
                                                    fontSize: 18
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              );
                            },
                            child: Icon(
                              IconAPP.moreHorizOutlined,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: 1,
                          color: ColorApp.greyColor.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            //
            // return state is SocialGetUserDataLoadingState && userModel != null
            //     ?
            // const Center(child: CircularProgressIndicator(),)
            //     :
            //
          },
        );
      },
    );
  }
}
