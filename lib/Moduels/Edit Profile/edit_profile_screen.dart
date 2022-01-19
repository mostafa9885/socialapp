

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Moduels/Edit%20Screens/Edit%20Bio/edit_bio_screen.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {

        var userModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.arrowLeft2),
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            title: const Text('Edit Profile'),
            titleSpacing: 0,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children:
              [
                newDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children:
                        [
                          const Text(
                            'Profile Picture',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const Spacer(),
                          if(state is SocialUploadProfileImageLoadingState)
                            Container(
                              width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                            ),

                          SocialCubit.get(context).profileImage != null
                            ?
                            D_TextButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).uploadProfileImage(

                                );
                              },
                              text: 'Save',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              context: context,
                            )
                            :
                            D_TextButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                              text: 'Edit',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              context: context,
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: ()
                      {
                        SocialCubit.get(context).getProfileImage();
                      },
                      highlightColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 85,
                        backgroundImage: profileImage == null
                            ?
                            NetworkImage('${userModel?.image}')
                            :
                            FileImage(profileImage) as ImageProvider,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Container(
                  color: ColorApp.greyColor.withOpacity(0.6),
                  width: double.infinity,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    [
                      Row(
                        children:
                        [
                          const Text(
                            'Cover Photo',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const Spacer(),
                          if(state is SocialUploadCoverImageLoadingState)
                            Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
                          SocialCubit.get(context).coverImage != null
                              ?
                          D_TextButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).uploadCoverImage();
                            },
                            text: 'Save',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            context: context,
                          )
                              :
                          D_TextButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).getCoverImage();
                            },
                            text: 'Edit',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            context: context,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: ()
                        {
                          SocialCubit.get(context).getCoverImage();
                        },
                        highlightColor: Theme.of(context).scaffoldBackgroundColor,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: coverImage == null
                                    ?
                                    NetworkImage(
                                  '${userModel?.cover}',
                                )
                                    :
                                    FileImage(coverImage) as ImageProvider,
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: ColorApp.greyColor.withOpacity(0.6),
                  width: double.infinity,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    [
                      Row(
                        children:
                        [
                          const Text(
                            'Bio',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const Spacer(),
                          userModel!.bio!.isEmpty
                              ?
                              D_TextButton(
                              context: context,
                              onPressed: ()
                              {
                                ShowModelBottomSheet (
                                  title: 'Add Bio',
                                  context: context,
                                  editWidget: EditBioScreen(),
                                );
                              },
                              text: 'Add',
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          )
                              :
                              D_TextButton(
                              context: context,
                              onPressed: ()
                              {
                                ShowModelBottomSheet (
                                  title: 'Edit Bio',
                                  context: context,
                                  editWidget: EditBioScreen(),
                                );
                              },
                              text: 'Edit',
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: ()
                        {
                          ShowModelBottomSheet (
                            title: 'Edit Bio',
                            context: context,
                            editWidget: EditBioScreen(),
                            onTap: ()
                            {
                              userModel.bio = '';
                              SocialCubit.get(context).updateUser(bio: userModel.bio);
                            }
                          );
                        },
                        highlightColor: Theme.of(context).scaffoldBackgroundColor,
                        child: Text(
                          '${userModel.bio}',
                          style: const TextStyle(
                            fontSize: 17
                          ),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
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
