import Log from '../utils/Logger';
import NetworkCrl from '../utils/NetWorkUtils';
import { NetWorkItem } from '../utils/NetWorkUtils';
import dataPreferences from '@ohos.data.preferences';
import Logger from '../utils/Logger';
import promptAction from '@ohos.promptAction';
import LoginModel from '../model/LoginModel';

class Tools {
  private preferences: dataPreferences.Preferences;

  sendSMS(phoneNumber: string) {
    let item = new NetWorkItem();
    item.setTargetUrl("/user/sendsms");
    item.setReqCode(200);
    item.addItem("account", phoneNumber);
    item.addItem("use", 2);
    NetworkCrl.sendRequest(item, (reqCode: number, responseCode: number, ret: string) => {
      Log.debug("reqCode:" + reqCode + " responseCode:" + responseCode + " ret:" + ret);
    });
  }

  async loginEvent(phoneNumber: string, password: string): Promise<string> {
    return new Promise<string>((resolve) => {
      let item = new NetWorkItem();
      let loginStatus = '';
      let parsedUserInfo;

      item.setTargetUrl("/user/login");
      item.setReqCode(200);
      item.addItem("account", phoneNumber);
      item.addItem("password", password);
      item.addItem("mode", 2);
      dataPreferences.getPreferences(getContext(), 'userInfo').then((preferences) => {
        this.preferences = preferences;
      });
      NetworkCrl.sendRequest(item, (reqCode: number, responseCode: number, ret: string) => {
        parsedUserInfo = JSON.parse(JSON.parse(ret));
        loginStatus = parsedUserInfo.code;
        Log.debug("reqCode:" + reqCode + " responseCode:" + responseCode + " ret:" + ret);
        Log.debug("loginStatus: " + loginStatus + " userData" + parsedUserInfo);
        this.putPreferences(this.preferences, ret, 'userInfo_key');
        if (loginStatus == '0') {
          resolve(loginStatus);
        } else {
          promptAction.showToast({ message: $r('app.string.InvalidPasswordToast') });
        }
      });
    });
  }

  async signOut(): Promise<void> {
    let item = new NetWorkItem();
    let userInfoItems = await LoginModel.getInfo();
    let token = userInfoItems.user.token;

    item.setTargetUrl("/user/signout");
    item.addItem("token", token);
    NetworkCrl.sendRequest(item, (reqCode: number, responseCode: number, ret: string) => {
      let logOutInfo = JSON.parse(JSON.parse(ret));
      let loginOutStatus = logOutInfo.code;
      Log.debug("reqCode:" + reqCode + " responseCode:" + responseCode + " ret:" + ret);
      if (loginOutStatus == '0') {
        LoginModel.cleanUserInfoItem();
        promptAction.showToast({ message: $r("app.string.SignoutSuccess") });
      } else {
        promptAction.showToast({ message: $r("app.string.SignoutFailed") });
      }
    });

  }

  putPreferences(preferences: dataPreferences.Preferences, bit: any, key: string) {
    if (preferences == null) {
      return;
    }
    try {
      preferences.put(key, bit, (err) => {
        if (err) {
          Logger.error("Failed to put value of 'startup'. code =" + err.code + ", message =" + err.message);
        }
        preferences.flush((err) => {
          if (err) {
            Logger.error("Failed to flush. code =" + err.code + ", message =" + err.message);
          }
        })
      })
    }
    catch (err) {
      Logger.error("Failed to put value of 'startup'. code =" + (err).code + ", message =" + err.message);
    }
  }
}

export default new Tools();