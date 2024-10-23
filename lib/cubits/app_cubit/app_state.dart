abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingUserDataState extends AppStates {}

class AppSuccessUserDataState extends AppStates {}

class AppErrorUserDataState extends AppStates {
  final String error;
  AppErrorUserDataState(this.error);
}

class AppChanegeModeState extends AppStates {}

class AppChanegeOnBoardingState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppNewPostBottomNavState extends AppStates {}

class AppPickedProfileImageSuccessState extends AppStates {}

class AppPickedProfileImageErrorState extends AppStates {}

class AppPickedCoverImageSuccessState extends AppStates {}

class AppPickedCoverImageErrorState extends AppStates {}

class AppUploadProfileImageLoadingState extends AppStates {}
class AppUploadProfileImageSuccessState extends AppStates {}

class AppUploadProfileImageErrorState extends AppStates {}

class AppUploadCoverImageSuccessState extends AppStates {}

class AppUploadCoverImageErrorState extends AppStates {}
