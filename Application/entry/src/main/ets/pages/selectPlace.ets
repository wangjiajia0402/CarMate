import router from '@ohos.router';
import { getPosByWord } from '../network/api/nav'

interface Posi {
  address: string,

  [key: string]: any
}


@Entry
@Component
struct selectPlace {
  handleChange = async (val: string) => {
    console.log('val', val);
    const res = await getPosByWord({ keywords: val });
    console.log('res', JSON.stringify(res));
    this.pois = res.pois;
  }
  @State pois: Array<Posi> = [];

  onPageShow() {
    const params = router.getParams();
    console.log(JSON.stringify(params))
  }

  build() {
    Navigation() {
      Search({ placeholder: '请输入您的目的地' })
        .width('90%')
        .height(40)
        .searchButton('搜索')
        .onChange(this.handleChange)

      //列表
      List() {
        ForEach(this.pois, (item) => {
          ListItem() {
            Flex() {
              Image($r('app.media.location')).width('25lpx')
              Column() {
                Text(item.name).fontSize(18)
                Text(item.address).fontSize(12).fontColor(Color.Grey)
              }.alignItems(HorizontalAlign.Start).margin({ left: 10 })
            }.width('100%').padding(10).onClick(() => {
              const params: {
                startPlace: string,
                startLocationInfo: string
              } & any = router.getParams();
              router.pushUrl({
                url: 'pages/route',
                params: {
                  endLocationInfo: {
                    name: item.name,
                    targetAddress: item.address,
                    location: item.location
                  },
                  startLocationInfo: {
                    name: params.startPlace,
                    location: params.startLocationInfo
                  }
                }
              })
            })
          }
        }, item => item.id)
      }
    }
    .title('选择终点')
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
  }
}

