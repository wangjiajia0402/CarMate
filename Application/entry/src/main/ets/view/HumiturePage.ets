import socket from '@ohos.net.socket';

let udp = socket.constructUDPSocketInstance();

let localIp = '172.20.10.3';
let localPort = 52611;

// let remoteIp = '192.168.1.107';
// let remotePort = 3861;

@Component
export struct HumiturePage {
  @State temp: string = '23';
  @State humi: string = '60';

  build() {
    Column() {
      Image($r('app.media.car'))
        .width("100%")
        .height("85%")
        .objectFit(ImageFit.Contain)
      Row() {
        Column() {
          Text('车内温度')
            .fontWeight(500)
            .fontSize(18)
            .height(30)
          Text(this.temp + '℃')
        }.size({ width: '50%', height: '100%' })

        Column() {
          Text('车内湿度')
            .fontWeight(500)
            .fontSize(18)
            .height(30)
          Text(this.humi + '%')
        }
        .size({ width: '50%', height: '100%' })
      }
      .width("100%")
      .height("15%")
      .borderRadius(16)
      .padding(20)
      .onAppear(() => {
        this.bind()
      })
    }
    .width("100%")
    .height("100%")
  }

  bind() {
    let promise = udp.bind({ address: localIp, port: localPort, family: 1 });
    promise.then(() => {
      console.log('bind success');
    }).catch(err => {
      console.log('bind fail:' + JSON.stringify(err));
    });
    udp.on('message', value => {
      console.log("on message, message:" + JSON.stringify(value));
      //value中的message才是发送过来的数据，并且是ArrayBuffer类型，需要先转成string类型
      let dataView = new DataView(value.message)
      let index = 0;
      this.temp = ""
      this.humi = ""
      for (let i = 0; i < dataView.byteLength; ++i) {
        let c = String.fromCharCode(dataView.getUint8(i))
        if (c != ":") {
          if (index == 0) {
            this.temp += c
            console.log("udp on success" + this.temp);
          } else {
            this.humi += c
          }
        }
        if (c == ":") {
          index = 1;
        }
      }
      let recvData = this.arrayBufferToString(value.message);
      console.info("收到服务器发送过来的数据：" + recvData);
    });
  }

  arrayBufferToString(buffer) {
    return String.fromCharCode.apply(null, new Uint8Array(buffer))
  }
}