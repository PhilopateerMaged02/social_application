import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> archivedTasks = [];
String? token = '';
String? uId = '';
final supabase = Supabase.instance.client;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      // navigateToandKill(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
