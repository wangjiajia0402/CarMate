import { TitleBox } from '../view/TitleBox';
import Tools from '../common/Tools';
import call from '@ohos.telephony.call';

@Entry
@Component
struct PhonePage {
  @State title: string = Tools.getResourceString($r('app.string.phone'));

  build() {
    Column() {
      TitleBox({ title: this.title });
      Button("紧急呼叫")
        .width(140)
        .height(60)
        .fontSize(25)
        .fontColor(Color.White)
        .onClick(() => {
          let isSupport = call.hasVoiceCapability();
          if (!isSupport) {
            console.info(" support voice capability, return");
            return;
          }
          call.makeCall("110", (err) => {
            if (!err) {
              console.info(" make call success.");

            } else {
              console.info("make call fail, err is:" + JSON.stringify(err));
            }
          });
        })
    }
    .justifyContent(FlexAlign.Center)
  }
}