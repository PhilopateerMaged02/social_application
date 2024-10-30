import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:news_app/modules/web_view/web_view_screen.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/components/constants.dart';

import '../cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpeerCase = true,
  double radius = 0,
  required Function() function,
  required String text,
}) =>
    Container(
        height: 40,
        //color: background,
        width: width,
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpeerCase ? text.toUpperCase() : text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius),
        ));
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType input,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  Function()? onTap,
  bool isObscure = false,
  required FormFieldValidator<String> onValidator,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function()? onSuffix,
  bool isClickable = true,
}) =>
    TextFormField(
      cursorColor: Colors.blue,
      controller: controller,
      keyboardType: input,
      obscureText: isObscure,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: onValidator,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: onSuffix, icon: Icon(suffix))
            : null,
      ),
    );
Widget defaultTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text(
                '${model['time']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'DONE', id: model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'Archived', id: model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        //AppCubit.get(context).deleteDatabase(id: model['id']);
      },
    );
Widget defaultTaskView({
  required List<Map> l,
}) {
  return ConditionalBuilder(
    condition: l.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => defaultTaskItem(l[index], context),
        separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 3,
              color: Colors.grey[200],
            ),
        itemCount: l.length),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.black54,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'There is no Tasks , Add Some Tasks',
            style: TextStyle(color: Colors.grey, fontSize: 25),
          ),
        ],
      ),
    ),
  );
}

// Widget defaultArticleItem(article, context) {
//   return InkWell(
//     onTap: () {
//       navigateTo(context, WebViewScreen(article['url']));
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         //crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.cover),
//             ),
//           ),
//           SizedBox(
//             width: 15,
//           ),
//           Expanded(
//             child: Container(
//               height: 120,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '${article['title']}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       maxLines: 4,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   //SizedBox(height: 20,),
//                   Text(
//                     '${article['publishedAt']}',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Future navigateTo(context, widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

Future navigateToandKill(context, widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

void showToust({
  required String? message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    backgroundColor: chooseToastColor(state),
    fontSize: 16,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

// Widget buildFavItem(model, context) {
//   return Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Container(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               Image(
//                 image: NetworkImage(model.image ?? ''),
//                 width: 160,
//                 height: 100,
//               ),
//               if (model.discount != null && model.discount != 0)
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 5),
//                   child: Text(
//                     '  Discount  ',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.white,
//                       backgroundColor: Colors.red,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   model.name ?? 'No Name',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Text(
//                       model.price?.toString() ?? '0',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.blue),
//                     ),
//                     SizedBox(width: 15),
//                     if (model.discount != null && model.discount != 0)
//                       Text(
//                         model.oldPrice.toString(),
//                         style: TextStyle(
//                             decoration: TextDecoration.lineThrough,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 9),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 10),
//               Icon(Icons.arrow_forward_ios),
//               SizedBox(height: 40),
//               IconButton(
//                 icon: Icon(
//                   Icons.favorite,
//                   color: SocialAppCubit.get(context).favorites[model.id] ?? false
//                       ? Colors.red
//                       : Colors.grey,
//                 ),
//                 onPressed: () {
//                   ShopAppCubit.get(context).changeFavorites(model.id ?? 000);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
