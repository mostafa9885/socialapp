import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:socialapp3/Moduels/New%20Post/add_new_post_%20screen.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class SocialLayoutHome extends StatelessWidget {
  const SocialLayoutHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // if(state is SocialAddNewPostState)
        // {
        //   NavigatorTo(context, AddNewPostScreen());
        // }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            actions: [
              if (cubit.currentIndex == 0 || cubit.currentIndex == 3)
                IconButton(
                  onPressed: () {
                    NavigatorTo(context, AddNewPostScreen());
                  },
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: ColorApp.greyColor.withOpacity(0.2),
                    child: Icon(
                      IconBroken.paperUpload,
                      color: ColorApp.blackColor,
                    ),
                  ),
                ),
              if (cubit.currentIndex == 0)
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: ColorApp.greyColor.withOpacity(0.2),
                    child: Icon(
                      IconBroken.notification,
                      color: ColorApp.blackColor,
                    ),
                  ),
                ),
              IconButton(
                onPressed: ()
                {
                  //NavigatorTo(context, const SearchScreen());
                },
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: ColorApp.greyColor.withOpacity(0.2),
                  child: Icon(
                    IconBroken.search,
                    color: ColorApp.blackColor,
                  ),
                ),
              ),
            ],
            elevation: 0,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: SalomonBottomBar(
            curve: Curves.fastLinearToSlowEaseIn,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNavIndex(index);
              if (cubit.currentIndex == 1 || cubit.currentIndex == 3) {
                cubit.getUsers();
              }
            },
            items: [
              SalomonBottomBarItem(
                  icon: const Icon(IconBroken.home),
                  title: const Text('Home'),
                  selectedColor: ColorApp.mainColor),
              SalomonBottomBarItem(
                icon: const Icon(IconBroken.chat),
                title: const Text('Chats'),
              ),
              SalomonBottomBarItem(
                icon: CircleAvatar(
                  radius: 13,
                  backgroundImage: NetworkImage(
                    '${cubit.model?.image}',
                  ),
                ),
                title: const Text('Profile'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(IconBroken.user1),
                title: const Text('Users'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(IconBroken.setting),
                title: const Text('Setting'),
              ),
            ],
          ),
        );
      },
    );
  }
}
