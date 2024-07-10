import webview from '@ohos.web.webview';
import router from '@ohos.router';
import NetworkMonitor from '../utils/NetworkMonitor';
import promptAction from '@ohos.promptAction';
@Component
export struct Map {
  @State startPlace: string = '请选择起点';
  @State startLocationInfo: string = '';
  @State data1: string = ''
  private networkMonitor: NetworkMonitor = new NetworkMonitor();
  onPageShow() {
    // 页面即将显示时订阅网络状态
    this.networkMonitor.subscribe();
    this.networkMonitor.onNetworkChange = (type) => {
      this.data1 = type;
      console.log('Network type changed:', this.data1);
      if (!this.data1) {
        // 弹出警告提示对话框
        promptAction.showToast({
          message: '请连接网络后再尝试',
          duration: 2000
        });
      }
    };
  }
  //创建一个webview的控制器
  webController: webview.WebviewController = new webview.WebviewController();
  ports: webview.WebMessagePort[];
  initPorts = () => {
    this.ports = this.webController.createWebMessagePorts();
    this.webController.postMessage('__init_port__', [this.ports[0]], '*');
    this.ports[1].onMessageEvent((result: webview.WebMessage) => {
      console.log('从web传递过来的数据', result);
      const res = JSON.parse(result as string)
      if (res.type === 'passLocation') {
        this.startPlace = res.payload.name;
        this.startLocationInfo = res.payload.location;
      }
    })
  }


  @Styles
  orderForm(){
    .width('100%').height('100%')
  }

  @Styles
  formZone(){
    .width('90%')
    .height('300lpx')
    .backgroundColor(Color.White)
    .offset({ y: -10 })
    .borderRadius(10)
    .shadow({ radius: 40, color: 0x000000, offsetX: 15, offsetY: 15 })
  }

  @Styles
  formItem(){
    .width('100%').height('120lpx').padding({ left: 15 })
  }


// //处理权限的获取
//   private permissions:Array<Permissions>=[
//     'ohos.permission.APPROXIMATELY_LOCATION',
//     'ohos.permission.LOCATION'
//   ]
//   reqPermissionsFromUser(permissions: Array<Permissions>):void{
//     let atManger = abilityAccessCtrl.createAtManager();
//     atManger.requestPermissionsFromUser(this.context,permissions).then((data)=>{
//
//     })
//
//   }


  build() {
    Column() {
      Row() {
        Text('智能导航')
          .fontSize(20)
          .width('100%')
          .height('100%')
          .margin(10)
          .fontWeight(500)
          .textAlign(TextAlign.Center)
      }
      .width('92%')
      .height('7%')

      // 地图部分
      Column() {
        Web({
          src: $rawfile('homemap.html'),
          controller: this.webController
        })
          .onPageEnd(() => {
            //网页加载完成之后
            this.initPorts()
          })
      }
      .flexGrow(1)
      .height(0)
      .width('100%')

      //起点终点
      Column() {
        //起点选择
        Row() {
          Circle({ width: '15lpx', height: '15lpx' }).fill(Color.Green)
          Column() {
            Text(this.startPlace)
            Text('您常用的起点').fontSize(10)
          }.alignItems(HorizontalAlign.Start).margin({ left: 15 })
        }.formItem()

        //终点选择
        Row() {
          Circle({ width: '15lpx', height: '15lpx' }).fill(Color.Orange)
          Column() {
            Text('请选择终点')
          }.alignItems(HorizontalAlign.Start).margin({ left: 15 })
        }.formItem().backgroundColor(0xd2d2d2).borderRadius(15)
        .onClick(()=>{
          router.pushUrl({
            url: 'pages/selectPlace',
            params:{
              startLocationInfo: this.startLocationInfo,
              startPlace: this.startPlace
            }

          })
        })
      }.formZone().padding(10).translate({ y: -15 })
    }
    .width('100%')
    .height('100%')
  }
}