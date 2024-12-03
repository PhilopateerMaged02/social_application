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

class SocialAppGetPostsLoadingState extends SocialAppStates {}

class SocialAppGetPostsSuccessState extends SocialAppStates {}

class SocialAppGetPostsErrorState extends SocialAppStates {}

class SocialAppAddLikeSuccessState extends SocialAppStates {}

class SocialAppAddLikeErrorState extends SocialAppStates {}

class SocialAppToggleLikeLoadingState extends SocialAppStates {}

class SocialAppUnlikeSuccessState extends SocialAppStates {}

class SocialAppLikeSuccessState extends SocialAppStates {}

class SocialAppToggleLikeErrorState extends SocialAppStates {}

class SocialAppGetUsersLoadingState extends SocialAppStates {}

class SocialAppGetUsersSuccessState extends SocialAppStates {}

class SocialAppGetUsersErrorState extends SocialAppStates {}

class SocialAppGetMessagesLoadingState extends SocialAppStates {}

class SocialAppGetMessagesSuccessState extends SocialAppStates {}

class SocialAppGetMessagesErrorState extends SocialAppStates {}

class SocialAppSendMessagesSuccessState extends SocialAppStates {}

class SocialAppSendMessagesErrorState extends SocialAppStates {}
