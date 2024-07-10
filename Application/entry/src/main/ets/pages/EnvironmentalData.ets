import router from '@ohos.router';

@Entry
@Component
struct EnvironmentalData {
  private environmentalData: Array<{title: string, details: string[], color: string}> = [
    {
      title: "空气质量指数",
      details: ["AQI: 35", "PM2.5: 10μg/m³", "PM10: 20μg/m³"],
      color: "#FFCDD2"
    },
    {
      title: "风速和风向",
      details: ["风速: 5km/h", "风向: 东北"],
      color: "#BBDEFB"
    },
    {
      title: "日出日落时间",
      details: ["日出: 06:00 AM", "日落: 07:00 PM"],
      color: "#FFF9C4"
    },
    {
      title: "天气预报",
      details: ["今天: 晴朗", "明天: 小雨", "气温: 20°C - 25°C"],
      color: "#C8E6C9"
    },
    {
      title: "紫外线指数",
      details: ["UV指数: 中等"],
      color: "#F8BBD0"
    },
    {
      title: "汽车内外空气湿度",
      details: ["内部湿度: 45%", "外部湿度: 50%"],
      color: "#D1C4E9"
    },
    {
      title: "地理位置信息",
      details: ["经度: 120.12345", "纬度: 30.67890", "行驶方向: 北"],
      color: "#B2EBF2"
    },
    {
      title: "海拔高度",
      details: ["当前海拔: 800米"],
      color: "#FFECB3"
    },
    {
      title: "天文信息",
      details: ["当前星座: 狮子座", "星期: 星期五", "月相: 满月"],
      color: "#E1BEE7"
    }
  ];

  build() {
    Column() {

      Row() {
        Image($r('app.media.ic_back'))
          .width(30)
          .height(30)
          .onClick(() => router.back())
        Text("温度详情")
          .fontSize(20)
          .fontWeight('bold')
          .margin({ left: 10 })
      }
      .width('100%')
      .height(50)
      .padding({ left: 10, right: 10, top: 10, bottom: 10 })
      .justifyContent(FlexAlign.Start)

      Divider()
        .width('100%')
        .height(1)
        .backgroundColor('#ff000000')

      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.environmentalData, (dataItem, _) => {
          ListItem() {
            Column() {
              Text(dataItem.title)
                .fontSize(20)
                .fontWeight('bold')
                .padding({bottom: 5});
              ForEach(dataItem.details, (detail, _) => {
                Text(detail)
                  .fontSize(16)
                  .padding({top: 2, bottom: 2});
              });
            }
            .width('100%')
            .padding(10)
            .borderRadius(10)
            .backgroundColor(dataItem.color);
          }
        });
      }
      .listDirection(Axis.Vertical)
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 })
      .edgeEffect(EdgeEffect.Spring)
      .width('90%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 });
  }
}
