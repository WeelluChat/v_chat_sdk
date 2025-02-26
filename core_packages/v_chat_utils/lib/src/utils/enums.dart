// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

enum VLoadMoreStatus { loading, loaded, error, completed }

enum VChatPushService { firebase, onesignal }

enum VChatLoadingState { loading, success, error, ideal, empty }

enum VNotificationActionRes { click, push }

enum VSupportedFilesType {
  image,
  file,
  video,
}

enum VRoomTypingEnum { stop, typing, recording }

enum VStorageKeys {
  vAccessToken,
  vIsFirstRun,
  vAppMetaData,
  vAppLanguage,
  vClintVersion,
  vMyProfile,
  vAppTheme,
  vLastAppliedUpdate,
  vLastSuccessFetchRoomsTime,
  vIsLogin,
  vBaseUrl,
}

enum VAttachEnumRes { media, files, location }
