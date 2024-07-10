import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State num: number = 0;

  aboutToAppear() {
    setTimeout(function () {
      router.pushUrl({
        url: "pages/Index"
      })
    }, 5000)
  }

  build() {
    Column() {
      Stack() {
        Image($r('app.media.welcomebg'))
          .height('100%')
          .width('100%')
          .objectFit(ImageFit.Contain)
        // Button('点击跳过')
        //   .backgroundColor('#adadad')
        //   .width('20%')
        //   .height('5%')
        //   .margin({ top: '5%', right: '5%' })
        //   .onClick(() => {
        //     router.pushUrl({ url: 'pages/Index' });
        //     this.num = 1;
        //   })
      }
      .alignContent(Alignment.TopEnd)
      .height('80%')
      .width('100%')

      Column() {
        Image($r('app.media.Logo'))
          .height('80%')
          .width('40%')
          .objectFit(ImageFit.Contain)
      }
      .height('20%')
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }

  // pageTransition() {
  //   PageTransitionEnter({ duration: 2000, curve: Curve.Ease }).slide(SlideEffect.Top)
  //   PageTransitionExit({ duration: 2000, curve: Curve.EaseInOut }).slide(SlideEffect.Bottom)
  // }
}