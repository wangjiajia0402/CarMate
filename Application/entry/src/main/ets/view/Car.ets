import router from '@ohos.router'

@Component
export struct Car {
  build() {
    Column() {
      Row() {
        Text('汽车')
          .fontSize('20')
          .width('100%')
          .height('100%')
          .margin(10)
          .fontWeight(500)
          .textAlign(TextAlign.Center)
      }
      .width('92%')
      .height('7%')

      Row() {
        Image($r('app.media.odometer'))
          .width("20%")
          .height("100%")
          .objectFit(ImageFit.Contain)
        Column() {
          Text("统计")
            .width("95%")
            .height("50%")
            .fontColor(Color.Black)
            .margin({ left: "5%" })
            .fontSize("17fp")
          Text("Mr.Lee")
            .width("95%")
            .height("50%")
            .fontColor(Color.Black)
            .margin({ left: "5%" })
            .fontSize("18fp")
            .fontWeight(FontWeight.Bold)
        }
        .width("80%")
        .height("100%")
      }
      .width("80%")
      .height("10%")
      .margin({ top: '5%' })
      .alignItems(VerticalAlign.Center)

      Column() {


        //距离
        Text("距离")
          .width("100%")
          .height("8%")
          .fontColor(Color.Black)
          .fontSize("15fp")
        Divider()
          .width("100%")
          .height("1vp")
          .opacity(0.6)
        Row() {
          Image($r('app.media.commonly'))
            .width("15%")
            .height("60%")
            .objectFit(ImageFit.Contain)
          Column() {
            Text("里程表")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("15fp")
            Text("1221米")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("17fp")
              .fontWeight(FontWeight.Bold)
          }
          .width("85%")
          .height("100%")
        }
        .width("100%")
        .height("12%")
        .alignItems(VerticalAlign.Center)

        Divider()
          .width("95%")
          .height("1vp")
          .opacity(0.3)
        Row() {
          Image($r('app.media.scommonly'))
            .width("15%")
            .height("60%")
            .objectFit(ImageFit.Contain)
          Column() {
            Text("短距离里程表")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("15fp")
            Text("12米")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("17fp")
              .fontWeight(FontWeight.Bold)
          }
          .width("85%")
          .height("100%")
        }
        .width("100%")
        .height("12%")
        .alignItems(VerticalAlign.Center)

        //电量
        Text("汽车信息")
          .width("100%")
          .height("8%")
          .fontColor(Color.Black)
          .fontSize("15fp")
        Divider()
          .width("82%")
          .height("1vp")
          .opacity(0.6)
        Row() {
          Image($r('app.media.Electricity'))
            .width("15%")
            .height("60%")
            .objectFit(ImageFit.Contain)
          Column() {
            Text("电量")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("15fp")
            Text("100%")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("17fp")
              .fontWeight(FontWeight.Bold)
          }
          .width("85%")
          .height("100%")
        }
        .width("100%")
        .height("12%")
        .alignItems(VerticalAlign.Center)

        Divider()
          .width("95%")
          .height("1vp")
          .opacity(0.3)
        Row() {
          Image($r('app.media.distance'))
            .width("15%")
            .height("60%")
            .objectFit(ImageFit.Contain)
          Column() {
            Text("预计还能行驶")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("15fp")
            Text("780米")
              .width("100%")
              .height("50%")
              .fontColor(Color.Black)
              .fontSize("17fp")
              .fontWeight(FontWeight.Bold)
          }
          .width("85%")
          .height("100%")
        }
        .width("100%")
        .height("12%")
        .alignItems(VerticalAlign.Center)

        Button($r('app.string.RemoteControl'))
          .width("180vp")
          .height("40vp")
          .fontColor(Color.White)
          .margin({ top: "10%" })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/RemoteControl'
            })
          })
      }
      .width("80%")
      .height("70%")
    }
    .width('100%')
    .height('100%')
  }
}