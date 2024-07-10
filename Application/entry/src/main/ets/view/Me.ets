import router from '@ohos.router';
import { LoginComponent } from './LoginComponent';

class Item1 {
  text: Resource;
  image: Resource;

  constructor(text: Resource, image: Resource) {
    this.text = text;
    this.image = image;
  }
}

class Item2 {
  text: Resource;
  image: Resource;

  constructor(image: Resource, text: Resource) {
    this.text = text;
    this.image = image;
  }
}

@Component
export struct Me {
  @State buttonNum: number = 0;
  private items1: Array<Item1> = [
    new Item1($r('app.string.ConversionPrivacyPolicy'), $r("app.media.more")),
    new Item1($r('app.string.ConversionUserAgreement'), $r("app.media.more")),
    new Item1($r('app.string.Conversion_about'), $r("app.media.more")),
    new Item1($r('app.string.person_info_list'), $r("app.media.more")),
    new Item1($r('app.string.settings'), $r("app.media.more"))
  ]
  private items2: Array<Item2> = [
    new Item2($r("app.media.Poetry"), $r('app.string.Poetry')),
    new Item2($r("app.media.DailyWords"), $r('app.string.DailyWords')),
    new Item2($r("app.media.Joke"), $r('app.string.Joke'))
  ]

  build() {
    Column() {
      LoginComponent()
        .margin({ top: '4%' })
      Column() {
        Text('常用工具')
          .margin({ left: '7%',top: '2%' })
          .height('17%')
          .width('100%')
          .fontSize('16fp')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Start)
        Row() {
          ForEach(
            this.items2,
            (item: Item2,index:number) => {
              Column() {
                Image(item.image)
                  .objectFit(ImageFit.Contain)
                  .width('40%')
                  .height('40%')
                Text(item.text)
                  .fontSize('16fp')
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Center)
                  .width('100%')
                  .height('30%')
              }
              .onClick(() => {
                this.buttonNum = index;
                if (this.buttonNum == 0) {
                  router.pushUrl({
                    url: 'pages/PoetryPage'
                  })
                } else if (this.buttonNum == 1) {
                  router.pushUrl({
                    url: 'pages/DailyWordsPage'
                  })
                } else if (this.buttonNum == 2) {
                  router.pushUrl({
                    url: 'pages/JokePage'
                  })
                }
              })
              .width('33%')
            }
          )
        }
        .height('85%')
        .width('100%')
      }
      .height('15%')
      .width('90%')
      .borderWidth(1)
      .borderColor(Color.Black)
      .borderRadius(16)
      .margin({ top: '8%' })

      Column() {
        ForEach(
          this.items1,
          (item: Item1) => {
            Row() {
              Text(item.text)
                .fontSize('16fp')
                .fontWeight(FontWeight.Bold)
                .margin({ left: '5%' })
              Blank();
              Image(item.image)
                .width('8%')
                .margin({ right: '5%' })
                .objectFit(ImageFit.Contain)
            }
            .width('91%')
            .height('9%')
          }
        )
      }
      .borderWidth(1)
      .borderColor(Color.Black)
      .borderRadius(16)
      .margin({ top: '8%' })
    }
    .height('100%')
    .width('100%')
  }
}