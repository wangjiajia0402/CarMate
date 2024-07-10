@Component
export struct LockPage {
  @State isRightDoorLock: boolean = true;
  @State isLeftDoorLock: boolean = true;
  @State isskylightLock: boolean = true;
  @State isTrunkLock: boolean = true;
  @State RightImage: Resource = $r("app.media.doorclose");
  @State LeftImage: Resource = $r("app.media.doorclose");
  @State skylightImage: Resource = $r("app.media.doorclose");
  @State TrunkImage: Resource = $r("app.media.doorclose");

  build() {
    Column(){
      Image($r('app.media.car'))
        .width("100%")
        .height("85%")
        .objectFit(ImageFit.Contain)
      Image(this.isskylightLock === true ? this.skylightImage = $r("app.media.doorclose") : this.skylightImage = $r("app.media.dooropen"))
        .width(40)
        .height(40)
        .position({ x: 160, y: 270 })
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          this.isskylightLock = !this.isskylightLock;
        })
      Image(this.isLeftDoorLock === true ? this.LeftImage = $r("app.media.doorclose") : this.LeftImage = $r("app.media.dooropen"))
        .width(40)
        .height(40)
        .position({ x: 35, y: 250 })
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          this.isLeftDoorLock = !this.isLeftDoorLock;
        })
      Image(this.isRightDoorLock === true ? this.RightImage = $r("app.media.doorclose") : this.RightImage = $r("app.media.dooropen"))
        .width(40)
        .height(40)
        .position({ x: 270, y: 250 })
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          this.isRightDoorLock = !this.isRightDoorLock;
        })
      Image(this.isTrunkLock === true ? this.TrunkImage = $r("app.media.doorclose") : this.TrunkImage = $r("app.media.dooropen"))
        .width(40)
        .height(40)
        .position({ x: 160, y: 420 })
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          this.isTrunkLock = !this.isTrunkLock;
        })
    }
    .justifyContent(FlexAlign.Center)
    .width("100%")
    .height("100%")
  }
}