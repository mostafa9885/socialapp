
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class EditInformationScreen extends StatelessWidget {


  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {

        var model = SocialCubit.get(context).model;

        nameController.text = model!.name.toString();
        phoneController.text = model.phone.toString();
        emailController.text = model.email.toString();

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.arrowLeft2),
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            title: const Text('Edit Information'),
            titleSpacing: 0,
            actions:
            [
              D_TextButton(
                  context: context,
                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(
                      phone: phoneController.text,
                      name: nameController.text,
                      email: emailController.text
                    );
                  },
                  text: 'Save',
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                    'Personal and Account Information',
                    style: TextStyle(
                      color: ColorApp.blackColor,
                      fontSize: 21,
                      fontWeight: FontWeight.w600
                    ),
                ),
                const SizedBox(height: 25),
                if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                const SizedBox(height: 15),
                D_TextFromField(
                    controller: nameController,
                    label: 'Name',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    prefixIcon: IconBroken.user1,
                    keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                D_TextFromField(
                  controller: phoneController,
                  label: 'Phone',
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  prefixIcon: IconBroken.call,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                D_TextFromField(
                  controller: emailController,
                  label: 'Email',
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  prefixIcon: IconBroken.message,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
