import { tabArray, TabType, TabBarName } from '../mock/TabData';
import { Home } from '../view/Home';
import { Music } from '../view/Music';
import { Map } from '../view/Map';
import { Me } from '../view/Me';
import { Car } from '../view/Car';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController();

  @Builder
  TabBuilder(item: TabType) {
    Column() {
      Image(item.icon)
        .flexGrow(1)
        .height(30)
        .width('30%')
        .objectFit(ImageFit.Contain)
        .opacity(this.currentIndex === item.index ? 1 : 0.2)
      Text(item.text)
        .flexGrow(1)
        .fontSize(15)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height('100%')
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        ForEach(tabArray, (item: TabType) => {
          TabContent() {
            if (item.index === TabBarName.HOME) {
              Home({ controller: this.controller });
            } else if (item.index === TabBarName.MUSIC) {
              Music();
            } else if (item.index === TabBarName.MAP) {
              Map();
            } else if (item.index === TabBarName.CAR) {
              Car();
            } else if (item.index === TabBarName.ME) {
              Me();
            }
          }
          .tabBar(this.TabBuilder(item))
        })
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .scrollable(true)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .backgroundColor('#F8F8F8')
    .width('100%')
    .height('100%')
  }
}