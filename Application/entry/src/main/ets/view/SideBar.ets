import { CityModel } from '../model/CityModel'

@Component
export default struct SideBar {
  @Link selectCity: CityModel; //选中城市
  @Link isShowSideBar: boolean; //是否展示侧边栏
  @State cityArr: CityModel[] = [//城市列表
    { locationId: 101010100, locationName: '北京' }, { locationId: 101280601, locationName: '深圳' },
    { locationId: 101020100, locationName: '上海' }, { locationId: 101250101, locationName: '长沙' },
    { locationId: 101310101, locationName: '海口' }, { locationId: 101070201, locationName: '大连' }];

  build() {
    Column() {
      Text('城市选择')
        .fontSize(28)
        .width('100%')
        .fontColor('#E6000000')
        .padding({ top: 15, left: 22 })


      List({ space: 8, initialIndex: 0 }) {
        ForEach(this.cityArr, (item) => {
          ListItem() {
            if (this.selectCity.locationName == item.locationName) {
              Text(item.locationName)
                .width('100%')
                .fontSize(20)
                .fontColor('#E64F7EFD')
                .backgroundColor('#1A4F7EFD')
                .padding({ top: 10, bottom: 10, left: 22 })
            } else {
              Text(item.locationName)
                .width('100%')
                .fontSize(20)
                .borderRadius(10)
                .fontColor('#E6000000')
                .padding({ top: 10, bottom: 10, left: 22 })
            }
          }.onClick(() => {
            this.selectCity = item
            this.isShowSideBar = !this.isShowSideBar;
          })
        })
      }
      .width('100%')
      .height('80%')
      .margin({ top: 26 })
    }
    .width('100%')
    .height('100%')
    .align(Alignment.TopStart)
  }
}