import router from '@ohos.router'
import webView from '@ohos.web.webview';
import display from '@ohos.display';

@Entry
@Component
struct route {
  webController: webView.WebviewController = new webView.WebviewController();
  @State webHeight: number = 500;
  @State totalHeight: number = 0;

  aboutToAppear() {
    const displayInfo = display.getDefaultDisplaySync();
    this.totalHeight = px2vp(displayInfo.height)
    this.webHeight = this.totalHeight / 2
  }

  onPageShow() {
    const params = router.getParams();
    console.log(JSON.stringify(params))
  }

  ports: webView.WebMessagePort[];
  initport = () => {
    this.ports = this.webController.createWebMessagePorts();
    this.webController.postMessage('__init_port__', [this.ports[0]], '*');
    this.ports[1].onMessageEvent((result: webView.WebMessage) => {
      const res = JSON.parse(result as string)
      if (res.type === 'webready') {
        const rtparams = router.getParams();
        this.ports[1].postMessageEvent(JSON.stringify({
          type: 'drawLine',
          payload: rtparams || {
            "endLocationInfo": {
              "name": "上海明天广场JW万豪酒店",
              "targetAddress": "南京西路399号(人民广场地铁站11号口步行240米)",
              "location": "121.469617,31.230404"
            },
            "startLocationInfo": {
              "name": "上海市浦东新区曹路镇上海杉达学院金海校区谢希德堂",
              "location": "121.658837,31.269392"
            }
          }
        }))
      }
    })
  }

  build() {
    Stack() {
      Column() {
        Web({ src: $rawfile('routemap.html'), controller: this.webController })
          .height(this.webHeight).width('100%').onPageEnd(this.initport)
      }.width('100%').height('100%')

      //pane
      Panel(true) {

      }.visibility(Visibility.Visible)
      .type(PanelType.Foldable).mode(PanelMode.Half)
      .dragBar(true)
      .miniHeight(138)
      .onChange((width: number, height: number, mode: PanelMode) => {
        console.log('高度变化', `mode${mode}_height${height}`)
        if (mode === 2) {
          this.webHeight = 8
        }
        if (mode === 1) {
          this.webHeight = this.totalHeight / 2
          this.ports[1].postMessageEvent(JSON.stringify({
            type: 'zoom-'
          }))
        }
        if (mode === 0) {
          this.webHeight = this.totalHeight - px2vp(height) - 8
          this.ports[1].postMessageEvent(JSON.stringify({
            type: 'zoom+'
          }))
        }
      })

      Column(){
        Button('立即出发').width('90%').backgroundColor(Color.Transparent)
          .linearGradient({
            direction: GradientDirection.Left,
            repeating: true,
            colors:[[0xe08748,0.0],[0xc95e15,1]]
          })
      }

    }
    .height('100%')
    .width('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })
    .alignContent(Alignment.Bottom)
  }
}
