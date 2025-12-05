export class  PageModel {
  pageName: string | Resource;
  pageIcon: Resource|undefined;

  constructor( pageName: string | Resource, pageIcon: Resource | undefined = undefined) {
    this.pageName = pageName;
    this.pageIcon = pageIcon;
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