export class TabType {
  icon: Resource;
  text: Resource;
  index: number
}

export const tabArray: Array<TabType> = [
  {
    icon: $r('app.media.home'),
    text: $r('app.string.Tab_Home'),
    index: 0
  },
  {
    icon: $r('app.media.music'),
    text: $r('app.string.Tab_Music'),
    index: 1
  },
  {
    icon: $r('app.media.map'),
    text: $r('app.string.Tab_Map'),
    index: 2
  },
  {
    icon: $r("app.media.TabCar"),
    text: $r('app.string.Tab_Car'),
    index: 3
  },
  {
    icon: $r("app.media.me"),
    text: $r('app.string.Tab_Me'),
    index: 4
  }
]

export enum TabBarName {
  HOME = 0,
  MUSIC = 1,
  MAP = 2,
  CAR = 3,
  ME = 4
}

