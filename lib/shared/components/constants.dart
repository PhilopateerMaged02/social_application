import 'package:news_app/modules/ShopApp/shop_login/login_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> archivedTasks = [];
String? token = '';
void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigateToandKill(context, LoginScreen());
    }
  });
}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}