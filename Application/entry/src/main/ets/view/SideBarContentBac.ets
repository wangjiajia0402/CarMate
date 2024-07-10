@Component
export default struct SideBarContentBac {
  @Link isShowSideBar: boolean;

  build() {
    //灰色背景
    Column()
      .size({ width: '100%', height: '100%' })
      .backgroundColor('#FF818385')
      .onClick(() => {
        this.isShowSideBar = !this.isShowSideBar
      })
  }
}