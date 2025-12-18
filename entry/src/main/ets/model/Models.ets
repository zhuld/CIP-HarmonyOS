export class PageModel {
  pageName: string | Resource;
  pageIcon: Resource | undefined;

  constructor(pageName: string | Resource, pageIcon: Resource | undefined = undefined) {
    this.pageName = pageName;
    this.pageIcon = pageIcon;
  }
}

export class Pages {
  title: string | Resource;
  subTitle: string | Resource;
  pageList: PageModel[];

  constructor(title: string | Resource = '', subTitle: string | Resource = '', pageList: PageModel[]) {
    this.title = title;
    this.subTitle = subTitle;
    this.pageList = pageList;
  }
}

export class ButtonModel {
  buttonId: number;
  buttonName: string | Resource;
  buttonIcon: Resource | undefined;
  buttonColor: ResourceColor |undefined;
  constructor(buttonId: number, buttonName: string | Resource = '' , buttonIcon: Resource | undefined = undefined ,buttonColor: ResourceColor | undefined = undefined) {
    this.buttonId = buttonId;
    this.buttonName = buttonName;
    this.buttonIcon = buttonIcon;
    this.buttonColor = buttonColor
  }
}

export class Buttons {
  title: string | Resource;
  icon : Resource | undefined;
  subTitle: string | Resource;
  buttonList: ButtonModel[];
  checkId: number;

  constructor(title: string | Resource = '', subTitle: string | Resource = '', icon: Resource | undefined = undefined ,buttonList: ButtonModel[], checkId: number = 0) {
    this.title = title;
    this.icon = icon;
    this.subTitle = subTitle;
    this.buttonList = buttonList;
    this.checkId = checkId
  }
}

export class VolumeModel {
  volumeId: number;
  volumeName: string | Resource;
  value: number;
  mini: number;
  max: number;

  constructor(volumeId: number, volumeName: string | Resource, value: number, mini: number, max: number) {
    this.volumeId = volumeId;
    this.volumeName = volumeName;
    this.value = value;
    this.mini = mini;
    this.max = max;
  }
}

export class Volumes {
  title: string | Resource;
  icon : Resource | undefined;
  subTitle: string | Resource;
  volumeList: VolumeModel[];

  constructor(title: string | Resource = '', subTitle: string | Resource = '', icon: Resource | undefined = undefined ,volumeList: VolumeModel[]) {
    this.title = title;
    this.icon = icon;
    this.subTitle = subTitle;
    this.volumeList = volumeList;
  }
}