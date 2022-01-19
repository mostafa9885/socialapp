
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Models/Post%20Model/post_model.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/constant.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.all(8),
                elevation: 8,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const Image(
                      image: NetworkImage(
                        'https://image.freepik.com/free-photo/satisfied-student-posing-against-pink-wall_273609-20219.jpg',
                      ),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Communicate with Friends',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: ColorApp.whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildPostItem(
                  SocialCubit.get(context).posts[index],
                  context,
                  index,
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: SocialCubit.get(context).posts.length,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildPostItem(PostModel postModel, context, index) => Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: ()
                  {
                    //NavigatorTo(context, UsersProfile(userModel: socialUserModel));
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${postModel.image}',
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${postModel.name}',
                            style: const TextStyle(
                                height: 1.4, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            IconAPP.checkCircle,
                            size: 16,
                            color: ColorApp.mainColor,
                          )
                        ],
                      ),
                      Text(
                          '${postModel.dataTime}',
                          style: caption(context)!.copyWith(
                              height: 1.4,
                          ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                  onPressed: ()
                  {

                  },
                  icon: const Icon(
                    IconBroken.moreCircle,
                    size: 20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1,
                color: ColorApp.greyColor.withOpacity(0.4),
              ),
            ),
            Text(
              '${postModel.text}',
              style: TextStyle(
                  color: ColorApp.blackColor,
                  fontSize: 15,
                  height: 1.3,
              ),
            ),
            const SizedBox(height: 5),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 10.0,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Computer_Engineer',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Computer_Engineer',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Computer_Engineer',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Computer_Engineer',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //         Container(
            //           height: 20,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               '#Civil_enginner',
            //               style: TextStyle(color: ColorApp.mainColor),
            //             ),
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if(postModel.postImage != '')
              Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${postModel.postImage}',
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.heart,
                              size: 20,
                              color: ColorApp.redAccent,
                            ),
                            const SizedBox(width: 5),
                            Text('0')
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.chat,
                              size: 20,
                              color: ColorApp.blueAccent,
                            ),
                            const SizedBox(width: 5),
                            const Text('0 comment'),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: ColorApp.greyColor.withOpacity(0.4),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).model!.image}',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Write a Comment ...',
                          style: caption(context)!.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.heart,
                        size: 20,
                        color: ColorApp.redAccent.withOpacity(0.8),
                      ),
                      const SizedBox(width: 5),
                      const Text('Like')
                    ],
                  ),
                  onTap: ()
                  {
                    //SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
