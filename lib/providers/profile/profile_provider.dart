import 'package:hangeureut/repositories/restaurant_repository.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../models/custom_error.dart';
import '../../models/user_model.dart';
import '../../repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileProvider extends StateNotifier<ProfileState> with LocatorMixin {
  ProfileProvider() : super(ProfileState.initial());

  //editOnboarding -> 온보딩 정보 업데이트(firestore)
  //editName -> 이름 정보 업데이트(firestore)

  Future<void> getProfile({required String uid}) async {
    state = state.copyWith(profileStatus: ProfileStatus.loading);
    try {
      final User user = await read<ProfileRepository>().getProfile(uid: uid);
      state = state.copyWith(profileStatus: ProfileStatus.loaded, user: user);
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
      rethrow;
    }
  }

  Future<User?> getOthersProfile({required String uid}) async {
    try {
      final User user = await read<ProfileRepository>().getProfile(uid: uid);

      return user;
    } on CustomError catch (e) {
      rethrow;
    }
  }

  Future<void> setLogin() async {
    try {
      await read<ProfileRepository>().setLogin();
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
    User newUser = state.user.copyWith(first: false);
    state = state.copyWith(user: newUser);
  }

  bool isFriends(String id) {
    for (var i in state.user.followings) {
      if (i["id"] == id) return true;
    }
    return false;
  }

  Future<void> setFriends(String id, String name, int icon) async {
    List newFriends = [];
    for (var i in state.user.followings) {
      newFriends.add(i);
      if (i["id"] == id) return;
    }

    newFriends.add({"id": id, "name": name, "icon": icon});
    try {
      await read<ProfileRepository>().setFollowings(
        myIcon: state.user.icon,
        myId: state.user.id,
        myName: state.user.name,
        id: id,
        name: name,
        icon: icon,
      );
      await read<ProfileRepository>()
          .setFollowers(followingId: id, currentUser: state.user);
      User newUser = state.user.copyWith(followings: newFriends);
      state = state.copyWith(user: newUser);
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> removeFriends(String id, String name, int icon) async {
    List newFriends = [];
    for (var friend in state.user.followings) {
      if (id != friend["id"]) {
        newFriends.add(friend);
      }
    }

    try {
      await read<ProfileRepository>().setFollowings(
          myId: state.user.id,
          myIcon: state.user.icon,
          myName: state.user.name,
          id: id,
          name: name,
          icon: icon,
          remove: true);
      User newUser = state.user.copyWith(followings: newFriends);
      state = state.copyWith(user: newUser);
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> setName({required String? name}) async {
    if (name == null || name == "") {
      throw CustomError(
        code: 'Exception',
        message: "이름은 한글자 이상이어야 합니다",
      );
    }
    try {
      await read<ProfileRepository>().setName(name: name);
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
    User newUser = state.user.copyWith(name: name);
    state = state.copyWith(user: newUser);
  }

  Future<void> setCId({required String? cID}) async {
    if (cID == null || cID == "") {
      throw CustomError(
        code: 'Exception',
        message: "아이디는 한글자 이상이어야 합니다",
      );
    }
    try {
      await read<ProfileRepository>().setCID(cID: cID);
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
    User newUser = state.user.copyWith(cId: cID);
    state = state.copyWith(user: newUser);
  }

  Future<void> setOnboarding({required Map onboarding}) async {
    final tasteCnt = onboarding["tasteKeyword"]
        .entries
        .where((e) => e.value == true)
        .toList()
        .length;
    final alcoholCnt = onboarding["alcoholType"]
        .entries
        .where((e) => e.value == true)
        .toList()
        .length;
    if (tasteCnt < 2) {
      throw CustomError(message: "입맛 키워드는 2개 이상 선택해주세요");
    } else if (alcoholCnt == 0) {
      throw CustomError(message: "주종은 1개 이상 선택해주세요");
    }
    try {
      await read<ProfileRepository>().setOnboarding(onboarding: onboarding);
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
    User newUser = state.user.copyWith(onboarding: onboarding);
    state = state.copyWith(user: newUser);
  }

  Future<void> saveRemoveRes(
      {required String resId,
      required String imgUrl,
      required bool isSave}) async {
    try {
      await read<RestaurantRepository>().saveRemoveRes(
          userId: state.user.id, resId: resId, imgUrl: imgUrl, isSave: isSave);
    } on CustomError {
      rethrow;
    }
    List saved = state.user.saved;
    List newSaved = [];
    if (isSave) {
      saved.add({"resId": resId, "imgUrl": imgUrl});
      newSaved = saved;
    } else {
      for (var e in saved) {
        if (e["resId"] != resId) {
          newSaved.add(e);
        }
      }
    }

    User newUser = state.user.copyWith(saved: newSaved);

    state = state.copyWith(user: newUser);
  }

  int findFollowingsIcon({required String id}) {
    for (var friend in state.user.followings) {
      if (friend["id"] == id) {
        return friend["icon"];
      }
    }
    return 21;
  }

  Future<void> reviewLike(
      {required String targetId,
      required String reviewId,
      required String resName,
      required bool isAdd}) async {
    String userId = state.user.id;
    int userIcon = state.user.icon;
    String userName = state.user.name;

    await read<RestaurantRepository>().reviewLike(
        userId: userId,
        userIcon: userIcon,
        userName: userName,
        targetId: targetId,
        reviewId: reviewId,
        resName: resName,
        isAdd: isAdd);
  }

  Future<List> searchUser({String? value}) async {
    List result = [];
    //following 돌기
    //follower 돌기
    //모든 계정 돌기

    return result;
  }
}
