import promptAction from '@ohos.promptAction';
import LoginModel from '../../model/LoginModel';
import Tools from '../../utils/LoginUtils';
import web_webview from '@ohos.web.webview'
import toBrowser from '../../utils/toBrowser';

@CustomDialog
export struct LoginDialog {
  controller: CustomDialogController;
  webController: web_webview.WebviewController = new web_webview.WebviewController();
  private phoneNumber: string = '';
  private password: string = '';
  @State sec: number = 30;
  @State flag: boolean = false;
  @State WaitForPassword: string = getContext().resourceManager.getStringSync($r('app.string.WaitPasswordText'));
  @State isRead: boolean = false;
  @Link userName: string;
  @Link loginStatus: number;
  @Link brief: string;
  @Link avatarUrl: string;

  build() {
    Column() {
      Row() {
        Text()
          .width(20)
        Text($r('app.string.PleaseLogin'))
          .fontSize(16)
          .fontWeight(500)
        Image($r('app.media.close')).size({ width: 20, height: 20 })
          .onClick(() => {
            this.controller.close()
          })
      }
      .height('16%')
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      TextInput({ placeholder: $r('app.string.PhoneNumberHolder') })
        .type(InputType.Number)
        .onChange((value: string) => {
          this.phoneNumber = value;
        })
        .maxLength(11)
        .height('16%')
        .width('90%')
        .margin({ top: '4%', bottom: '5%' })

      Stack() {
        TextInput()
          .height('100%')
          .width('100%')
          .type(InputType.Number)
          .onChange((value: string) => {
            this.password = value;
            if (this.password.length == 6) {
              if (this.phoneNumber.length == 11) {
                this.loginEventFinish();
              } else {
                promptAction.showToast({ message: $r('app.string.PhoneNumberToast') });
              }
            }
          })
          .maxLength(6)
        Text(this.flag ? (`${this.sec}` + this.WaitForPassword) : $r('app.string.GetPasswordText'))
          .fontSize(14)
          .height('81%')
          .width('35%')
          .fontColor($r('app.color.red_font'))
          .margin({ right: '2%' })
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.White)
          .borderRadius(18)
          .onClick(() => {
            if (this.phoneNumber.length != 11) {
              promptAction.showToast({ message: $r('app.string.PhoneNumberToast') });
            } else {
              if (!this.isRead) {
                promptAction.showToast({ message: $r('app.string.PrivacyToast') })
              } else {
                this.flag = true;
                this.materOnClick();
                Tools.sendSMS(this.phoneNumber);
              }
            }
          })
      }
      .alignContent(Alignment.End)
      .height('16%')
      .width('90%')

      Text($r('app.string.one_click_login'))
        .fontColor($r('app.color.red_font'))
        .height('16%')
        .margin({ top: '4%', bottom: '4%' })

      Row() {
        Toggle({ type: ToggleType.Checkbox, isOn: false })
          .size({ width: 16, height: 16 })
          .borderRadius(8)
          .selectedColor($r('app.color.red_font'))
          .onChange(() => {
            this.isRead = !this.isRead;
          })

        Web({ src: $rawfile('privateJson.html'), controller: this.webController })
          .height('7%')
          .width('73%')
          .defaultFontSize(40)
          .zoomAccess(false)
          .onUrlLoadIntercept((event) => {
            let url: string = event.data.toString();
            if (url.indexOf('native://') === 0) {
              toBrowser.browser('https://zmcalender.colaapp.cn/xcx_detail/' + url.substring(9) + '.html');
              return true;
            }
          })
      }
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .size({ width: '90%', height: '38%' })
    .borderRadius(16)
  }

  private materOnClick() {
    var T = setInterval(() => {
      if (this.sec <= 1) {
        clearTimeout(T);
        this.flag = false;
        this.sec = 30;
      } else {
        this.sec--;
      }
    }, 1000)
  }

  async loginEventFinish() {
    try {
      const result = await Tools.loginEvent(this.phoneNumber, this.password);
      let userInfoItems = await LoginModel.getInfo();
      this.userName = userInfoItems.data.nickname;
      this.loginStatus = userInfoItems.code;
      this.brief = userInfoItems.data.brief;
      this.avatarUrl= userInfoItems.data.avatar;
      this.controller.close();
      console.log(result);
    } catch (error) {
      console.error(error);
    }
  }
}
