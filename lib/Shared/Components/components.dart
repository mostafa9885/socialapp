
import 'package:flutter/material.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

void NavigatorTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget),
);

void NavigateAnfFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) => widget
  ),
      (rout) => false,
);


Widget D_TextFromField({
  required TextEditingController controller,
  required String label,
  required IconData prefixIcon,
  required TextInputType keyboardType,
  String? Function(String?)? validator,
  Function()? onTap,
  String? Function(String?)? onChange,
  String? Function(String?)? onSubmitted,
  TextStyle? labelStyle,
  TextStyle? styleOutDecoration,
  String? hintText,
  double hintStyleFS = 15,
  double borderSideWidth = 3,
  double borderRadiusCircular = 13,
  Color? prefixIconColor,
  IconData? suffixIcon,
  Function()? suffixPressed,
  bool isobscureText = false,
}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      keyboardType: keyboardType,
      style: styleOutDecoration,
      obscureText: isobscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: hintStyleFS,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
        label: Text(label),
        labelStyle: labelStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: borderSideWidth, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusCircular)),
        ),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffixIcon),
        ),
      ),
    );

Widget D_MaterialButton(
    {
      required Function() onPressed,
      Color backgroundColorButton = Colors.blue,
      double width = 250,
      bool isUpperCase = true,
      String text ='',
      Color textColor = Colors.white,
      double paddingSpace = 16.0,
      double raduis = 0.0,
      FontWeight? fontWeight,
    }) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(raduis)),
      ),
      child: MaterialButton(
        color: backgroundColorButton,
        onPressed: onPressed,
        height: 40,
        child: Text(
          isUpperCase? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );

Widget D_TextButton ({
  required Function() onPressed,
  required String text,
  required BuildContext context,
  double? fontSize,
  FontWeight? fontWeight,
  Color? backgroundColor,
}) => TextButton(
  onPressed: onPressed,
  style: ButtonStyle(
    overlayColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor)
  ),
  child: Text(
    text,
    style: TextStyle(
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,

    ),
  ),
);


Widget MyDivided ({required Color color, double? withOpacity}) => Container(
  width: double.infinity,
  height: 1,
  color: color,
);

void printFullText(String text){

  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void ShowModelBottomSheet ({

  required context,
  required String title,
  Widget? editWidget,
  Function()? onTap,

}) => showModalBottomSheet(
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
          SocialCubit.get(context).model!.bio!.isEmpty
              ?
          InkWell(
            onTap: ()
            {
              NavigatorTo(context, editWidget);
            },
            child: Row(
              children:
              [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorApp.greyColor.withOpacity(0.3),
                  child: const Icon(IconBroken.edit),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: ColorApp.blackColor,
                      fontSize: 18
                  ),
                ),
              ],
            ),
          )
              :
              isShowBottom(
                  context: context,
                  editWidget: editWidget,
                  onTap: onTap,
              )
        ],
      ),
    )
);

Widget isShowBottom({

  required context,
  String? title,
  Widget? editWidget,
  Function()? onTap,

}) => Column(
  mainAxisSize: MainAxisSize.min,
  children:
  [
    InkWell(
      onTap: ()
      {
        NavigatorTo(context, editWidget);
      },
      child: Row(
        children:
        [
          CircleAvatar(
            radius: 18,
            backgroundColor: ColorApp.greyColor.withOpacity(0.3),
            child: const Icon(IconBroken.edit),
          ),
          const SizedBox(width: 10),
          Text(
            'Edit Bio',
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: ColorApp.blackColor,
                fontSize: 18
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 20),
    InkWell(
      onTap: onTap,
      child: Row(
        children:
        [
          CircleAvatar(
            radius: 18,
            backgroundColor: ColorApp.greyColor.withOpacity(0.3),
            child: const Icon(IconBroken.delete),
          ),
          const SizedBox(width: 10),
          Text(
            'Remove Bio',
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: ColorApp.blackColor,
                fontSize: 18
            ),
          ),
        ],
      ),
    )
  ],
);

Widget newDivider() => Container(
  color: ColorApp.greyColor.withOpacity(0.6),
  width: double.infinity,
  height: 1,
);
