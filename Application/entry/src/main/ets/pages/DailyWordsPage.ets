import { TitleBox } from '../view/TitleBox';
import Tools from '../common/Tools';
import http from '@ohos.net.http';

@Entry
@Component
struct DailyWordsPage {
  @State content: string = '世间好物不坚牢，彩云易散琉璃碎。'
  @State author: string = '白居易'
  @State title: string = Tools.getResourceString($r('app.string.DailyWords'));

  aboutToAppear() {
    let httpRequest = http.createHttp()
    let promise = httpRequest.request("https://v2.alapi.cn/api/mingyan?token=", {
      method: http.RequestMethod.POST
    });
    promise.then((data) => {
      this.content = JSON.parse(`${data.result}`).data.content;
      this.author = JSON.parse(`${data.result}`).data.author;
    })
  }

  build() {
    Column() {
      TitleBox({ title: this.title });
      Stack() {
        Row() {
          Column() {
            Text('       ' + this.content)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)

            Row() {
              Blank()
              Text('——' + this.author)
                .fontSize(20)
            }.width('100%').margin({
              top: '10%',
              bottom: '20%'
            })

            Button() {
              Text('刷新').fontColor(Color.White)
            }.onClick(() => {
              let httpRequest = http.createHttp()
              let promise = httpRequest.request("https://v2.alapi.cn/api/mingyan?token=GdueeuQNDxxmQPUL", {
                method: http.RequestMethod.POST
              });
              promise.then((data) => {
                this.content = JSON.parse(`${data.result}`).data.content;
                this.author = JSON.parse(`${data.result}`).data.author;
              })
            }).height('8%').width('60%')
          }
          .width('95%')
        }
        .opacity(0.9)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .height('98%')
        .padding({
          left: '5%',
          right: '5%'
        })
      }.width('100%').height('100%')
      .linearGradient({
        direction: GradientDirection.RightTop,
        colors: [[0xff00fff8, 0.0], [0xff6200ff, 0.5], [0xffff00e5, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
  }
}