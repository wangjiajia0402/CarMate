import router from '@ohos.router'
import { RingPage } from './RingPage';
import { LockPage } from '../view/LockPage';
import { TirePressurePage } from './TirePressurePage';
import { HumiturePage } from '../view/HumiturePage';
import { SpeedPage } from './SpeedPage';

class Item {
  image: Resource
  name: Resource

  constructor(image: Resource, name: Resource) {
    this.image = image;
    this.name = name;
  }
}

class Item2 {
  image: Resource
  imageNum: number

  constructor(image: Resource, imageNum: number) {
    this.image = image;
    this.imageNum = imageNum;
  }
}


@Component
export struct Home {
  controller: TabsController;
  scroller: Scroller = new Scroller;
  @State currentIndex: number = 0;
  @State Visibility: string = 'Visibility.None';
  @State buttonNum: number = 0;
  @State SpeedVisibility: Visibility = Visibility.Visible;
  @State CarVisibility: Visibility = Visibility.None;
  @State HumitureVisibility: Visibility = Visibility.None;
  @State AQIVisibility: Visibility = Visibility.None;
  @State LockVisibility: Visibility = Visibility.None;
  private items: Array<Item> = [
    new Item($r('app.media.Weather'), $r('app.string.Weather')),
    new Item($r('app.media.phone'), $r('app.string.phone')),
    new Item($r('app.media.log'), $r('app.string.log')),
    new Item($r('app.media.ParkingAssist'), $r('app.string.ParkingAssist'))
  ]
  private items2: Array<Item2> = [
    new Item2($r('app.media.speed'), 0),
    new Item2($r('app.media.bell'), 1),
    new Item2($r('app.media.Temperature'), 2),
    new Item2($r('app.media.TirePressure'), 3),
    new Item2($r('app.media.Lock'), 4)
  ]

  build() {
    Scroll(this.scroller) {
      Column() {
        Row() {
          Text('CarMate智能车机系统')
            .fontSize('20')
            .width('85%')
            .margin(10)
            .fontWeight(500)
          Image($r('app.media.notice'))
            .width('5%')
            .objectFit(ImageFit.Contain)
            .margin(5)
        }
        .width('92%')
        .height('7%')

        Row() {
          ForEach(
            this.items,
            (item: Item, index: number) => {
              Column() {
                Column() {
                  Image(item.image)
                    .height('60%')
                    .width('70%')
                    .objectFit(ImageFit.Contain)
                  Text(item.name)
                    .height('25%')
                    .width('100%')
                    .fontSize(17)
                    .textAlign(TextAlign.Center)
                    .fontWeight(500)
                }
                .onClick(() => {
                  this.buttonNum = index;
                  if (this.buttonNum == 0) {
                    router.pushUrl({
                      url: 'pages/WeatherPage'
                    })
                  } else if (this.buttonNum == 1) {
                    router.pushUrl({
                      url: 'pages/PhonePage'
                    })
                  } else if (this.buttonNum == 2) {
                    router.pushUrl({
                      url: 'pages/UseLogPage'
                    })
                  } else if (this.buttonNum == 3) {
                    router.pushUrl({
                      url: 'pages/ParkingAssistPage'
                    })
                  }
                })
                .width('80%')
                .height('100%')
              }
              .width('25%')
              .height('100%')
            }
          )
        }
        .width('95%')
        .height('10%')
        .margin({ top: '3%' })

        Divider()
          .width("90%")
          .height("1vp")
          .opacity(0.7)
          .margin({ top: '2%' })

        Row() {
          Column() {
            ForEach(
              this.items2,
              (item: Item2, imageNum: number) => {
                Column() {
                  Image(item.image)
                    .width("100%")
                    .height("100%")
                    .objectFit(ImageFit.Contain)
                    .opacity(this.currentIndex === imageNum ? 1 : 0.2)
                  Divider()
                    .width("100%")
                    .height("1vp")
                    .opacity(0.7)
                    .strokeWidth("2vp")
                    .color(this.currentIndex === imageNum ? Color.Green : Color.Black)
                }
                .onClick(() => {
                  this.currentIndex = imageNum;
                  if (imageNum == 0) {
                    this.SpeedVisibility = Visibility.Visible;
                    this.CarVisibility = Visibility.None;
                    this.HumitureVisibility = Visibility.None;
                    this.AQIVisibility = Visibility.None;
                    this.LockVisibility = Visibility.None;
                  }
                  if (imageNum == 1) {
                    this.SpeedVisibility = Visibility.None;
                    this.CarVisibility = Visibility.Visible;
                    this.HumitureVisibility = Visibility.None;
                    this.AQIVisibility = Visibility.None;
                    this.LockVisibility = Visibility.None;
                  } else if (imageNum == 2) {
                    this.SpeedVisibility = Visibility.None;
                    this.CarVisibility = Visibility.None;
                    this.HumitureVisibility = Visibility.Visible;
                    this.AQIVisibility = Visibility.None;
                    this.LockVisibility = Visibility.None;
                  } else if (imageNum == 3) {
                    this.SpeedVisibility = Visibility.None;
                    this.CarVisibility = Visibility.None;
                    this.HumitureVisibility = Visibility.None;
                    this.AQIVisibility = Visibility.Visible;
                    this.LockVisibility = Visibility.None;
                  } else if (imageNum == 4) {
                    this.SpeedVisibility = Visibility.None;
                    this.CarVisibility = Visibility.None;
                    this.HumitureVisibility = Visibility.None;
                    this.AQIVisibility = Visibility.None;
                    this.LockVisibility = Visibility.Visible;
                  }
                })
                .width("50%")
                .height("33.3%")
              }
            )
          }
          .width("20%")
          .height("40%")
          .margin({ bottom: '25%' })

          Column() {
            SpeedPage()
              .visibility(this.SpeedVisibility)

            RingPage()
              .visibility(this.CarVisibility)

            HumiturePage()
              .visibility(this.HumitureVisibility)

            TirePressurePage()
              .visibility(this.AQIVisibility)

            LockPage()
              .visibility(this.LockVisibility)
          }
          .width("80%")
          .height("100%")
        }
        .width("90%")
        .height("78%")
      }
      .width("100%")
    }
    .width("100%")
    .height("100%")
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .align(Alignment.Top)
    .backgroundColor('#F8F8F8')
  }
}