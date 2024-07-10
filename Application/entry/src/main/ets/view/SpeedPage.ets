import socket from '@ohos.net.socket';

let tcp = socket.constructTCPSocketInstance();
// 绑定IP地址和端口。

let bindAddress = {
  address: '192.168.137.111',
  port: 7777, // 绑定端口，如1234
  family: 1
};
let connectAddress = {
  address: '192.168.137.165',
  port: 7777,
  family: 1
};
@Component
export struct SpeedPage {
  @State line: number = 0
  @State arc: number = 0
  @State num: Number = 0
  @State speed1:string = '';
  @State speed2:string = '';
  aboutToAppear() {
    console.log('socket:订阅接受');
    tcp.on('message', value => {
      console.log("socket:on message")
      let buffer = value.message
      let dataView = new DataView(buffer)
      let str = ""
      for (let i = 0; i < dataView.byteLength; ++i) {
        str += String.fromCharCode(dataView.getUint8(i))
      }
      let arr = str.split(',')

      console.info("socket:Received:" + str)
      this.speed1 = arr[0]
      this.speed2 = arr[1]

    });
    tcp.on('connect', () => {
      console.log("socket:on connect")
    });
    tcp.on('close', () => {
      console.log("socket:on close")
    });
    tcp.bind(bindAddress, err => {

      tcp.connect({ address: connectAddress, timeout: 6000 }, err => {
        setInterval(function(){
          this.num = this.num + 1
          let str = `${this.line}` + ',' + `${this.arc}`
          console.log("senddata:" + str)
          tcp.send({ data: str }, err => {
          })
        }.bind(this), 1000);
      });
    });

  }
  build() {
    Column() {
      Row(){
        Column(){
          Column() {
            Text('线速度')
              .fontWeight(500)
              .fontSize(18)
              .height(30)
            Text(this.speed1)
          }.size({ width: '100%', height: '30%' })
          Column() {
            Text('角速度')
              .fontWeight(500)
              .fontSize(18)
              .height(30)
            Text(this.speed2)
          }
          .size({ width: '100%', height: '30%' })
        }.width("20%")
        .height("100%")
        .margin({top: '70%'})
        Image($r('app.media.car'))
          .width("80%")
          .height("100%")
          .objectFit(ImageFit.Contain)
      }.width("100%")
      .height("80%")


      Row() {
        Column() {
          Row() {
            Button("小车前进")
              .width("33%")
              .height("80%")
              .borderRadius("8vp")
              .backgroundColor("#c2c2c2")
              .fontColor(Color.Black)
              .type(ButtonType.Normal)
              .fontSize("15fp")
              .opacity(0.7)
              .margin({ left: '30%', right: '5' })
            .onClick(() => {
              this.line = 0.2
            })
            Button("小车后退")
              .width("33%")
              .height("80%")
              .borderRadius("8vp")
              .backgroundColor("#c2c2c2")
              .fontColor(Color.Black)
              .type(ButtonType.Normal)
              .fontSize("15fp")
              .opacity(0.7)
            .onClick(() => {
              this.line = -0.2
            })
          }
          .width("100%")
          .height("50%")

          Row() {
            Button("小车左转")
              .width("33%")
              .height("80%")
              .borderRadius("8vp")
              .backgroundColor("#c2c2c2")
              .fontColor(Color.Black)
              .type(ButtonType.Normal)
              .fontSize("15fp")
              .opacity(0.7)
              .margin(5)
            .onClick(() => {
              this.arc = 1
            })
            Button("小车停止")
              .width("33%")
              .height("80%")
              .borderRadius("8vp")
              .backgroundColor("#c2c2c2")
              .fontColor(Color.Black)
              .type(ButtonType.Normal)
              .fontSize("15fp")
              .opacity(0.7)
              .margin(5)
            .onClick(() => {
              this.line = 0
              this.arc = 0
            })
            Button("小车右转")
              .width("33%")
              .height("80%")
              .borderRadius("8vp")
              .backgroundColor("#c2c2c2")
              .fontColor(Color.Black)
              .type(ButtonType.Normal)
              .fontSize("15fp")
              .opacity(0.7)
              .margin(5)
            .onClick(() => {
              this.arc = -1
            })
          }
          .width("100%")
          .height("50%")
        }
        .width("100%")
        .height("100%")
        .alignItems(HorizontalAlign.Center)
      }
      .width("100%")
      .height("20%")
      .borderRadius(16)
      .padding(10)
    }
    .width("100%")
    .height("100%")
  }
}