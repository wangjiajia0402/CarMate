import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';

class toBrowser {
  browser(url: string) {
    let context = getContext(this) as common.UIAbilityContext;
    let want: Want = {
      deviceId: '',
      bundleName: '',
      abilityName: '',
      action: 'android.intent.action.VIEW',
      uri: url
    };

    context.startAbility(want);
  }
}

export default new toBrowser();