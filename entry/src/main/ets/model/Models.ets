export class  PageModel {
  pageId: number;
  pageName: string | Resource;
  pageIcon: Resource|undefined;

  constructor(pageId: number, pageName: string | Resource, pageIcon: Resource | undefined = undefined) {
    this.pageId = pageId;
    this.pageName = pageName;
    this.pageIcon = pageIcon;
    //this.classifyContent = classifyContent;
  }
}

export class ButtonModel {
  buttonId: number;
  buttonName: string | Resource;
  buttonIcon: Resource | undefined;
  constructor(buttonId: number, buttonName: string | Resource = '' , buttonIcon: Resource | undefined = undefined) {
    this.buttonId = buttonId;
    this.buttonName = buttonName;
    this.buttonIcon = buttonIcon;
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