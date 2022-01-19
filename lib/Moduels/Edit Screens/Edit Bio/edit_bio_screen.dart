
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class EditBioScreen extends StatelessWidget {
  const EditBioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {

        var userModel = SocialCubit.get(context).model;
        var bioController = TextEditingController();

        bioController.text = userModel!.bio.toString();

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.arrowLeft2),
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Edit Bio',
            ),

            actions:
            [
              D_TextButton(
                  context: context,
                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(bio: bioController.text);
                  },
                  text: 'Save',
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ],
            titleSpacing: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children:
              [
                Container(
                  color: ColorApp.greyColor.withOpacity(0.6),
                  width: double.infinity,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          CircleAvatar(
                            radius: 23,
                            backgroundImage: NetworkImage(
                              '${userModel.image}',
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
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                        ),
                        child: Column(
                          children:
                          [
                            const Text(
                                'You can add a short bio to tell pepole '
                                'more about your self, This could be anything like '
                                'a favorite quote or what makes you happy'
                            ),
                            TextField(
                              controller: bioController,
                              keyboardType: TextInputType.multiline,
                              maxLength: 101,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      if(state is SocialUserUpdateLoadingState)
                        Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
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
