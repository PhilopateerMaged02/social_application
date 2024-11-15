abstract class SocialAppStates {}

class SocialAppInitialState extends SocialAppStates {}

class SocialAppGetUserLoadingState extends SocialAppStates {}

class SocialAppGetUserSuccessState extends SocialAppStates {}

class SocialAppGetUserErrorState extends SocialAppStates {
  final String error;
  SocialAppGetUserErrorState(String string, {required this.error});
}

class SocialAppChangeBottomNavState extends SocialAppStates {}

class SocialAppPickedProfileImageSuccessState extends SocialAppStates {}

class SocialAppPickedProfileImageErrorState extends SocialAppStates {}

class SocialAppPickedCoverImageSuccessState extends SocialAppStates {}

class SocialAppPickedCoverImageErrorState extends SocialAppStates {}

class SocialAppUpdateUserLoadingState extends SocialAppStates {}

class SocialAppUpdateUserSuccessState extends SocialAppStates {}

class SocialAppUpdateUserErrorState extends SocialAppStates {}

class SocialAppCreatePostLoadingState extends SocialAppStates {}

class SocialAppCreatePostSuccessState extends SocialAppStates {}

class SocialAppCreatePostErrorState extends SocialAppStates {}

class SocialAppInsertIntoTableSuccessState extends SocialAppStates {}

class SocialAppInsertIntoTableErrorState extends SocialAppStates {}
