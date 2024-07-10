import { TitleBox } from '../view/TitleBox';
import Tools from '../common/Tools';

@Entry
@Component
struct JokePage {
  @State title: string = Tools.getResourceString($r('app.string.Poetry'));

  build() {
    Column() {
      TitleBox({ title: this.title });
    }
  }
}