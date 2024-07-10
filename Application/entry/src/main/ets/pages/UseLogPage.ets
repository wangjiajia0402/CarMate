import { TitleBox } from '../view/TitleBox';
import Tools from '../common/Tools';
@Entry
@Component
struct UseLogPage {
  @State title: string = Tools.getResourceString($r('app.string.log'));
  build() {
    Column() {
      TitleBox({ title: this.title });
      Image($r('app.media.uselog'))
        .width('115%')
        .height('100%')
        .objectFit(ImageFit.Contain)
        .margin({bottom: '20%'})
    }
    .justifyContent(FlexAlign.Start)
    .width("100%")
    .height('100%')
  }
}