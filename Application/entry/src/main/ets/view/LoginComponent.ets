import { LoginDialog } from './dialog/LoginDialog'
import LoginModel from '../model/LoginModel'

@Component
export struct LoginComponent {
  loginDialog: CustomDialogController = new CustomDialogController({
    builder: LoginDialog({
      userName: $userName,
      loginStatus: $loginStatus,
      brief: $brief,
      avatarUrl: $avatarUrl
    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: '0vp', dy: '-20vp' },

    customStyle: true
  })
  @State loginStatus: number = NaN;
  @State userName: string = getContext().resourceManager.getStringSync($r('app.string.NotLoggedIn'));
  @State brief: string = getContext().resourceManager.getStringSync($r('app.string.NotLoggedInBrief'));
  @State avatarUrl: string = '';
  private userInfoItems: any;

  async aboutToAppear() {
    this.userInfoItems = await LoginModel.getInfo();
    this.loginStatus = this.userInfoItems.code;
    this.userName = this.userInfoItems.data.nickname;
    this.brief = this.userInfoItems.data.brief;
    this.avatarUrl = this.userInfoItems.data.avatar;
  }

  build() {
    Row() {
      Image(this.loginStatus === 0 ? this.avatarUrl : $r('app.media.avatar_default'))
        .size({ width: 64, height: 64 })
        .borderRadius(32)
      Column() {
        Text(`${this.userName}`)
          .fontSize(19)
          .fontWeight(500)
          .fontColor('#333333')
        Text(`${this.brief}`)
          .fontSize(14)
          .fontWeight(400)
          .fontColor('#999999')
          .margin({ top: 8 })
      }
      .height(41)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 12 })

      Blank()
    }
    .width('91%')
    .onClick(() => {
      if (this.loginStatus != 0) {
        this.loginDialog.open();
      }
    })
  }
}