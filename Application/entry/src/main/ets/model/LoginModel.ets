import dataPreferences from '@ohos.data.preferences';
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';

class LoginModel {
  private userInfoItems: any;
  private userDataItems: Array<UserDataItem> = [];
  private userItems: Array<UserItem> = [];
  private userinfo: any;
  private context = getContext(this) as common.UIAbilityContext;
  private filesDir = this.context.filesDir;

  async cleanUserInfoItem() {
    let preferences = await dataPreferences.getPreferences(getContext(), 'userInfo');
    this.userInfoItems = [];
    preferences.clear();
    preferences.flush();
    try {
      fs.unlinkSync(this.filesDir + '/media/Photos/Avatar.png');
    } catch (err) {
      console.error(`Failed to delete image file, error: ${err}`);
    }
  }

  createUserDataItem() {
    return new UserDataItem(
      this.userinfo.data.area,
      this.userinfo.data.avatar,
      this.userinfo.data.birthday,
      this.userinfo.data.brief,
      this.userinfo.data.collectNum,
      this.userinfo.data.constellation,
      this.userinfo.data.fansNum,
      this.userinfo.data.ideaNum,
      this.userinfo.data.isBindWx,
      this.userinfo.data.isLogout,
      this.userinfo.data.isLunar,
      this.userinfo.data.isOfficial,
      this.userinfo.data.isPwd,
      this.userinfo.data.likeNum,
      this.userinfo.data.msgFansNum,
      this.userinfo.data.msgNum,
      this.userinfo.data.nickname,
      this.userinfo.data.sex,
      this.userinfo.data.starNum
    );
  }

  createUserItem() {
    return new UserItem(
      this.userinfo.user.phone,
      this.userinfo.user.token,
      this.userinfo.user.uid
    );
  }

  setInfo(data) {
    this.userinfo = JSON.parse(JSON.parse(data.toString()));
    const userDataItem = this.createUserDataItem();
    const userItem = this.createUserItem();
    this.userItems.push(userItem);
    this.userDataItems.push(userDataItem);
    this.userInfoItems = new UserInfoItem(
      this.userinfo.code,
      userDataItem,
      this.userinfo.msg,
      userItem
    );
  }

  async getInfo(): Promise<UserInfoItem | undefined> {
    if (!this.userInfoItems) {
      let preferences = await dataPreferences.getPreferences(getContext(), 'userInfo');
      let data = await preferences.get('userInfo_key', '');
      if (data) {
        this.setInfo(data);
      }
    }
    return this.userInfoItems;
  }
}

export default new LoginModel();

export class UserInfoItem {
  code: number;
  data: UserDataItem;
  msg: string;
  user: UserItem;

  constructor(code, data, msg, user) {
    this.code = code,
    this.data = data,
    this.msg = msg,
    this.user = user
  }
}

class UserDataItem {
  area: string;
  avatar: string;
  birthday: string;
  brief: string;
  collectNum: number;
  constellation: string;
  fansNum: number;
  ideaNum: number;
  isBindWx: boolean;
  isLogout: number;
  isLunar: boolean;
  isOfficial: boolean;
  isPwd: boolean;
  likeNum: number;
  msgFansNum: number;
  msgNum: number;
  nickname: string;
  sex: number;
  starNum: number;

  constructor(area: string, avatar: string, birthday: string, brief: string, collectNum: number, constellation: string, fansNum: number, ideaNum: number, isBindWx: boolean, isLogout: number, isLunar: boolean, isOfficial: boolean, isPwd: boolean, likeNum: number, msgFansNum: number, msgNum: number, nickname: string, sex: number, starNum: number) {
    this.area = area;
    this.avatar = avatar;
    this.birthday = birthday;
    this.brief = brief;
    this.collectNum = collectNum;
    this.constellation = constellation;
    this.fansNum = fansNum;
    this.ideaNum = ideaNum;
    this.isBindWx = isBindWx;
    this.isLogout = isLogout;
    this.isLunar = isLunar;
    this.isOfficial = isOfficial;
    this.isPwd = isPwd;
    this.likeNum = likeNum;
    this.msgFansNum = msgFansNum;
    this.msgNum = msgNum;
    this.nickname = nickname;
    this.sex = sex;
    this.starNum = starNum;
  }
}

class UserItem {
  phone: string;
  token: string;
  uid: number;

  constructor(phone: string, token: string, uid: number) {
    this.phone = phone;
    this.token = token;
    this.uid = uid;
  }
}
