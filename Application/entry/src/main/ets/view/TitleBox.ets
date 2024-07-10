import router from '@ohos.router';

@Component
export struct TitleBox {
  private title: string;

  build() {
    Row() {
      Image($r('app.media.back'))
        .width('7%')
        .objectFit(ImageFit.Contain)
        .margin(5)
        .onClick(() => {
          router.back();
        })
      Text(this.title)
        .fontSize(18)
        .margin(5)
    }
    .width('92%')
    .height('7%')
    .margin(5)
  }
}