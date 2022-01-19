
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Moduels/Edit%20Profile/edit_profile_screen.dart';
import 'package:socialapp3/Moduels/Edit%20Screens/Edit%20Bio/edit_bio_screen.dart';
import 'package:socialapp3/Moduels/Edit%20Screens/Edit%20Information/edit_information_screen.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Components/constant.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class ProfileScreen extends StatelessWidget {

  double x = 70;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {

        var userModel = SocialCubit.get(context).model;


        return state is SocialGetUserDataLoadingState && userModel != null
            ?
        const Center(child: CircularProgressIndicator(),)
            :
        SingleChildScrollView(
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
                            IconButton(
                              icon: CircleAvatar(
                                radius: 16,
                                backgroundColor: ColorApp.greyColor.withOpacity(0.8),
                                child: Icon(
                                  IconBroken.camera,
                                  size: 25,
                                  color: ColorApp.blackColor,
                                ),
                              ),
                              onPressed: ()
                              {
                                NavigatorTo(context, EditProfileScreen());
                              },
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
                          IconButton(
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorApp.greyColor.withOpacity(0.8),
                              child: Icon(
                                IconBroken.camera,
                                size: 22,
                                color: ColorApp.blackColor,
                              ),
                            ),
                            onPressed: ()
                            {
                              NavigatorTo(context, EditProfileScreen());
                            },
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
                const SizedBox(height: 4),


                userModel!.bio!.isNotEmpty ?
                TextButton(
                  onPressed: ()
                  {
                    ShowModelBottomSheet (
                      title: 'Edit Bio',
                      context: context,
                      editWidget: EditBioScreen(),
                      onTap: ()
                      {
                        userModel.bio = '';
                        SocialCubit.get(context).updateUser(bio: SocialCubit.get(context).model!.bio);
                      }
                    );
                  },
                  child: Container(
                    alignment: AlignmentDirectional.topCenter,
                    width: 300,
                    height: userModel.bio!.length > 10 && userModel.bio!.length < 20
                        ?
                    x = 30
                        :
                    userModel.bio!.length > 21 && userModel.bio!.length < 101
                        ?
                    x = userModel.bio!.length * 0.99999999
                        :
                    userModel.bio!.length < 9
                        ?
                    x = 22
                        :
                    null,
                    child: Text(
                      '${userModel.bio}',
                      style: caption(context)!.copyWith(
                        color: ColorApp.blackColor,
                        fontSize: 15,
                        fontFamily: 'Quicksand',
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                    overlayColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                  ),
                )
                    :
                const SizedBox(height: 22),




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
                        icon: const Icon(IconBroken.plus),
                        label: const Text('Add Story'),
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
                          NavigatorTo(context, EditProfileScreen());
                        },
                        icon: const Icon(IconBroken.edit),
                        label: const Text('Edit Profile'),
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
                                      NavigatorTo(context, EditInformationScreen());
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
        );
      },
    );
  }
}

