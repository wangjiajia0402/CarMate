import { TitleBox } from '../view/TitleBox';
import Tools from '../common/Tools';
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

@Entry
@Component
struct RemoteControl {
  @State message: string = '线速度：   角速度：'
  @State title: string = Tools.getResourceString($r('app.string.RemoteControl'));
  @State line: number = 0
  @State arc: number = 0
  @State num: Number = 0
  @State speed1: string = '';
  @State speed2: string = '';

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
      TitleBox({ title: this.title });
      Column() {
        TextInput({ placeholder: "请输入小车ip" })
          .width("250vp")
          .height("56.36vp")
        TextInput({ placeholder: "请输入手机端ip" })
          .width("250vp")
          .height("56.36vp")
          .margin({ top: "5vp" })
        Button("链接")
          .width("180vp")
          .height("50vp")
          .backgroundColor("#6da8df")
          .fontColor(Color.White)
          .margin({ top: "10vp" })
          .fontSize("20fp")
        Button("断开")
          .width("180vp")
          .height("50vp")
          .backgroundColor("#6da8df")
          .fontColor(Color.White)
          .margin({ top: "10vp" })
          .fontSize("20fp")
      }
      .width("50%")
      .height("25%")
      .margin('5%')

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
        .height("20%")

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
        .height("20%")
      }
      .width("70%")
      .height("40%")
      .margin({ top: '10%' })
      .alignItems(HorizontalAlign.Start)
    }
    .width("100%")
    .height("100%")
  }
}

