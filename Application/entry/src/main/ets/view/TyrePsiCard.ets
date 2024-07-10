@Entry
@Component
export struct TyrePsiCard {
  // private text: string = ''
  private x: number = 0
  private y: number = 0
  private boardColor: Color = Color.Red
  private isBottomTwoTyre: boolean = true;

  build() {
    Column() {
      if (this.isBottomTwoTyre) {
        Text("23.6psi",).fontSize(20)
          .fontColor(Color.Orange)
        Text("56.0\u2103").fontSize(15)
          .fontColor(Color.Orange).margin({ bottom: '20' })
        Text("Low").fontSize(20)
          .fontColor(Color.Orange)
        Text("Pressure").fontSize(15)
          .fontColor(Color.Orange)
      } else {
        Text("Low").fontSize(20)
          .fontColor(Color.Orange)
        Text("Pressure").fontSize(15).margin({ bottom: '20' })
          .fontColor(Color.Orange)
        Text("23.6psi",).fontSize(20)
          .fontColor(Color.Orange)
        Text("56.0\u2103").fontSize(15)
          .fontColor(Color.Orange)
      }
    }
    .border({
      width: 2,
      color: this.boardColor
    })
    .width(115)
    .height(115)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    //    .padding({ left: 10, bottom: 20, top: 20 })
    .position({ x: this.x, y: this.y })

  }
}