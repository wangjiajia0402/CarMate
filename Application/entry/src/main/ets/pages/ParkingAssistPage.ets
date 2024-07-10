import { TitleBox } from '../view/TitleBox';
import Tools from '../common/Tools';
import webView from '@ohos.web.webview';
import NetworkMonitor from '../utils/NetworkMonitor';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ParkingAssistPage {
  @State title: string = Tools.getResourceString($r('app.string.ParkingAssist'));
  @State private webSrc: string = "http://192.168.137.165:8000/TogetheROS/";
  @State data: string = ''
  webController: webView.WebviewController = new webView.WebviewController();
  private networkMonitor: NetworkMonitor = new NetworkMonitor();

  onPageShow() {
    // 页面即将显示时订阅网络状态
    this.networkMonitor.subscribe();
    this.networkMonitor.onNetworkChange = (type) => {
      this.data = type;
      console.log('Network type changed:', this.data);
      if (!this.data) {
        // 弹出警告提示对话框
        promptAction.showToast({
          message: '请连接网络后再尝试',
          duration: 2000
        });
      }
    };
  }

  build() {
    Column() {
      TitleBox({ title: this.title });
      Web({
        src: this.webSrc,
        controller: this.webController
      })
        .size({ width: '100%', height: '100%' })
    }
  }
}

