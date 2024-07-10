import { TitleBox } from '../view/TitleBox';
import Tools from '../common/Tools';
import SideBar from '../view/SideBar'
import SideBarContent from '../view/SideBarContent'
import SideBarContentBac from '../view/SideBarContentBac'
import { CityModel } from '../model/CityModel'
import { WeatherUiModel } from '../model/WeatherUiModel'
import utils from '../utils/utils'
import { getNowWeather, get7dWeather, get24hWeather } from '../network/api/WeatherApi'
import { NowWeatherModel, Weather7dModel, Weather24hModel } from '../model/NowWeatherModel'

@Entry
@Component
struct WeatherPage {
  @State title: string = Tools.getResourceString($r('app.string.Weather'));
  @State isShowSideBar: boolean = false;
  controller: TabsController;
  scroller: Scroller = new Scroller;
  @State @Watch('initData') selectCity: CityModel = { locationId: 101021300, locationName: '上海' };
  @State weatherUiModel: WeatherUiModel = {
    nowTemp: 0,
    nowWeatherText: 0,
    tempMax: 0,
    tempMin: 0,
    category: 0,
    precip: 0,
    hourlyTemp: [],
    iconDays: [],
    date: '-月-日',
    day: '',
    dayArr: [],
    hoursArr: [],
  };

  //生命周期接口
  aboutToAppear(){
    this.initData()
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBox({ title: this.title });
        SideBarContainer(SideBarContainerType.Embed) {
          // 侧边栏
          SideBar({ selectCity: $selectCity, isShowSideBar: $isShowSideBar })

          if (this.isShowSideBar) {
            //灰底
            SideBarContentBac({ isShowSideBar: $isShowSideBar })
          } else {
            // 内容
            SideBarContent({ isShowSideBar: $isShowSideBar, selectCity: $selectCity, weatherUiModel: $weatherUiModel })
              .onClick(() => {
                this.initData();
              })
          }
        }
        .showControlButton(false)
        .showSideBar(this.isShowSideBar)
        .autoHide(false)
        .sideBarWidth(160)
        .width('100%')
      }
      .width("100%")
    }
    .width("100%")
    .height("100%")
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  //初始化数据
  async initData() {
    let resultNow = await getNowWeather(this.selectCity.locationId);
    let weatherNow = resultNow.result as NowWeatherModel;
    this.weatherUiModel.nowTemp = weatherNow.now.temp;
    this.weatherUiModel.precip = weatherNow.now.precip;
    this.weatherUiModel.nowWeatherText = weatherNow.now.text;
    this.weatherUiModel.category = weatherNow.now.windDir;

    //获取24小时天气信息
    this.weatherUiModel.hoursArr = utils.getHoursArr();
    let result24h = await get24hWeather(this.selectCity.locationId);
    let weather24h = result24h.result as Weather24hModel;
    this.weatherUiModel.hourlyTemp = [];
    for (let index = 0; index < 5; index++) {
      this.weatherUiModel.hourlyTemp.push({ temp: weather24h.hourly[index].temp });
    }

    //获取近7日天气
    this.weatherUiModel.dayArr = utils.getDayArr();
    let result7d = await get7dWeather(this.selectCity.locationId);
    let weather7d = result7d.result as Weather7dModel;
    this.weatherUiModel.tempMax = weather7d.daily[0].tempMax;
    this.weatherUiModel.tempMin = weather7d.daily[0].tempMin;
    this.weatherUiModel.iconDays = [];
    for (let index = 0; index < 5; index++) {
      this.weatherUiModel.iconDays.push({ iconDay: weather7d.daily[index].iconDay+'.svg' });
    }

    //日期信息
    this.weatherUiModel.date = utils.getDate()
    this.weatherUiModel.day = utils.getDay()
  }
}