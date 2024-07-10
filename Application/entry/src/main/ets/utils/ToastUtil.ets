import promptAction from '@ohos.promptAction';
import Constants from '../common/constants/Constants';

export function showToast(msg: string | Resource) {
  promptAction.showToast({
    message: msg,
    duration: Constants.ANIMATION_DURATION
  });
}