@Component
export struct RingPage {
  build() {
    Column() {
      Image($r('app.media.car'))
        .width("100%")
        .height("85%")
        .objectFit(ImageFit.Contain)

      Row(){
        Column() {
          Image($r('app.media.ringon'))
            .width("30%")
            .height("70%")
            .objectFit(ImageFit.Contain)
          Text("响铃找车")
            .width("100%")
            .height("30%")
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
            .fontSize("20fp")
            .fontWeight(FontWeight.Bold)
        }
        .width("47%")
        .height("100%")

        Column() {
          Image($r('app.media.ringoff'))
            .width("30%")
            .height("70%")
            .margin({ left: "15%" })
            .objectFit(ImageFit.Contain)
          Text("响铃关闭")
            .width("100%")
            .height("30%")
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
            .fontSize("20fp")
            .fontWeight(FontWeight.Bold)
        }
        .width("47%")
        .height("100%")
        .margin({ right: '6%' })
      }
      .width("100%")
      .height("15%")
    }
    .width("100%")
    .height("100%")
  }
}