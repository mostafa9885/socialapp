

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';
import 'New Post Screen/Add Tags Post Screen/TagPostScreen.dart';
import 'New Post Screen/Add feel Post Screen/TagPostScreen.dart';

class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state)
      {
        if(state is SocialCreatNewPostSuccessState)
        {
          Navigator.pop(context);
        }
      },
      builder: (context, state)
      {
        var postController = TextEditingController();
        var userModel = SocialCubit.get(context).model;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.arrowLeft2),
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            title: const Text('Creat Post'),
            titleSpacing: 0,
            actions:
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorApp.blueAccent),
                  ),
                  onPressed: ()
                  {
                    var now = DateTime.now();
                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).creatPost(
                        dataTime: now.toString(),
                        text: postController.text,
                      );
                    }else
                      {
                        SocialCubit.get(context).uploadPostImage(
                          text: postController.text,
                          dataTime: now.toString(),
                        );
                      }
                    },
                  child: const Text('POST'),
                ),
              ),
            ],
          ),
          body: Column(
            children:
            [
              newDivider(),
              if(state is SocialCreatNewPostLoadingState)
                LinearProgressIndicator(
                  color: ColorApp.mainColor,
                  backgroundColor: ColorApp.greyColor,
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        '${userModel!.image}',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children:
                      [
                        Text(
                          '${userModel.name}',
                          style: const TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children:
                          [
                            Icon(
                              IconAPP.publicOutlined,
                              size: 20,
                            ),
                            const SizedBox(width: 3),
                            const Text(
                              'Public',
                              style: TextStyle(
                                  height: 1.4
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: TextFormField(
                    controller: postController,
                    maxLines: 50,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              if(SocialCubit.get(context).postImage != null)
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 10),
                  child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: FileImage(
                                SocialCubit.get(context).postImage!,
                            ),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorApp.blackColor.withOpacity(0.6),
                        child: Icon(
                          IconBroken.closeSquare,
                          size: 25,
                          color: ColorApp.whiteColor,
                        ),
                      ),
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                    ),
                  ],
              ),
                ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items:
            [
              const BottomNavigationBarItem(
                icon: Icon(
                    IconBroken.image,
                    color: Colors.green,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                    IconBroken.user,
                    color: Colors.blueAccent,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    IconAPP.faceOutlined,
                    color: Colors.amber,
                ),
                label: '',
              ),
            ],
            onTap: (int index)
            {
              SocialCubit.get(context).changePostBottomNavIndex(index);

              if (SocialCubit.get(context).postCurrentIndex == 0)
              {
                SocialCubit.get(context).getPostImage();
              }
              else if (SocialCubit.get(context).postCurrentIndex == 1)
              {
                NavigatorTo(context, TagPostScreen());
              }
              else
              {
                NavigatorTo(context, FeelPostScreen());
              }
            },
            currentIndex: SocialCubit.get(context).postCurrentIndex,
            elevation: 1,
          ),
        );
      },
    );
  }
}
