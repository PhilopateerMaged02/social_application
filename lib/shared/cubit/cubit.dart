import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:path/path.dart';
class AppCubit extends Cubit<AppStates>
{
   AppCubit() : super(AppInitialStates());
   static AppCubit get(context) => BlocProvider.of(context);

   bool isDark = false;
   void changeAppMode({bool? fromShared})
   {
      if(fromShared != null)
      {
         isDark = fromShared;
         emit(AppChangeModeState());
      }
      else
      {
        isDark = !isDark;
        CacheHelper.putData(key: 'isDark', value: isDark).then((value)
        {
           emit(AppChangeModeState());
        });
      }
   }

  void updateDatabase({required String status, required id}) {}
   ///////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

}