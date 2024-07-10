import Header from '../common/Header'
import Player from '../common/Player'
import Content from '../common/Content'
import BreakpointSystem from '../model/MediaData'

@Component
export struct Music {
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'

  aboutToAppear() {
    this.breakpointSystem.register()
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  build() {
    Column() {
      Header()
      Content()
        .height('100%')
        .flexGrow(1)
        .flexShrink(1)
      Player()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.currentBreakpoint === 'sm' ? '#e4ecf7' : '#f6f9fc')
  }
}