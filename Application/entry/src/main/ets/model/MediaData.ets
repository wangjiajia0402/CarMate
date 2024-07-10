import mediaQuery from '@ohos.mediaquery'

export default class BreakpointSystem {
  private currentBreakpoint: string = 'md'
  private smListener: mediaQuery.MediaQueryListener
  private mdListener: mediaQuery.MediaQueryListener
  private lgListener: mediaQuery.MediaQueryListener

  private updateCurrentBreakpoint(breakpoint: string) {
    if (this.currentBreakpoint !== breakpoint) {
      this.currentBreakpoint = breakpoint
      AppStorage.Set<string>('currentBreakpoint', this.currentBreakpoint)
    }
  }

  private isBreakpointSM = (mediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentBreakpoint('sm')
      AppStorage.Set<number>('fontSize', 14)
      AppStorage.Set<number>('coverMargin', 10)
    }
  }
  private isBreakpointMD = (mediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentBreakpoint('md')
      AppStorage.Set<number>('fontSize', 16)
      AppStorage.Set<number>('coverMargin', 30)
    }
  }
  private isBreakpointLG = (mediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentBreakpoint('lg')
      AppStorage.Set<number>('fontSize', 18)
      AppStorage.Set<number>('coverMargin', 40)
    }
  }

  public register() {
    this.smListener = mediaQuery.matchMediaSync('(320vp<=width<600vp)')
    this.smListener.on('change', this.isBreakpointSM)
    this.mdListener = mediaQuery.matchMediaSync('(600vp<=width<840vp)')
    this.mdListener.on('change', this.isBreakpointMD)
    this.lgListener = mediaQuery.matchMediaSync('(840vp<=width)')
    this.lgListener.on('change', this.isBreakpointLG)
  }

  public unregister() {
    this.smListener.off('change', this.isBreakpointSM)
    this.mdListener.off('change', this.isBreakpointMD)
    this.lgListener.off('change', this.isBreakpointLG)
  }
}