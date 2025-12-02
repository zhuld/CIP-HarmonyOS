import { ButtonModel, PageModel, VolumeModel } from "../../model/Models";

export const PageList: PageModel[] = [
  new PageModel(1, $r('app.string.home'), $r('app.media.home')),
  new PageModel(2, $r('app.string.HDMI'),$r('app.media.HDMI')),
  new PageModel(3, $r('app.string.volume'), $r('app.media.volume')),
  new PageModel(4, $r('app.string.camera'), $r('app.media.camera')),
  new PageModel(5, $r('app.string.setup'), $r('app.media.setup')),
];

export const Test_Home_1: ButtonModel[] = [
  new ButtonModel(11, '', $r('app.media.home')),
  new ButtonModel(12, $r('app.string.HDMI')),
  new ButtonModel(13, $r('app.string.volume'), $r('app.media.volume')),
  new ButtonModel(14, $r('app.string.camera'), $r('app.media.camera')),
];

export const Test_Home_2: ButtonModel[] = [
  new ButtonModel(21, '', $r('app.media.volume')),
  new ButtonModel(22, $r('app.string.camera'), $r('app.media.camera')),
  new ButtonModel(23, $r('app.string.HDMI'), $r('app.media.HDMI')),
  new ButtonModel(24, $r('app.string.volume'), $r('app.media.volume')),
  new ButtonModel(25, $r('app.string.camera'), $r('app.media.camera')),
  new ButtonModel(26, $r('app.string.home'), $r('app.media.home')),
];

export const Test_Video_Input: ButtonModel[] = [
  new ButtonModel(31, $r('app.string.video')),
  new ButtonModel(32, $r('app.string.camera')),
  new ButtonModel(33, $r('app.string.HDMI')),
  new ButtonModel(34, $r('app.string.volume')),
  new ButtonModel(35, $r('app.string.camera')),
  new ButtonModel(36, $r('app.string.home')),
  new ButtonModel(37, $r('app.string.setup')),
];


export const Test_Video_Output: ButtonModel[] = [
  new ButtonModel(41, "大屏", $r('app.media.LED')),
  new ButtonModel(42, "返看", $r('app.media.tv')),
  new ButtonModel(43, "监视器", $r('app.media.monitor')),
  new ButtonModel(44, "预留", $r('app.media.HDMI')),
];

export  const  Test_Volume_Input: VolumeModel[] =[
  new VolumeModel(51, '无线麦克风', -10, -30, 0),
  new VolumeModel(52, '有线麦克风', 0, -30, 0),
  new VolumeModel(53, '音乐', 0, -30, 0),
];


export  const  Test_Volume_Output: VolumeModel[] =[
  new VolumeModel(54, "总音量", 0, -30, 6),
];

export const Test_Camera: ButtonModel[] = [
  new ButtonModel(0),
  new ButtonModel(61, "", $r('sys.media.ohos_ic_public_arrow_up')),
  new ButtonModel(0),
  new ButtonModel(62, "", $r('sys.media.ohos_ic_public_arrow_left')),
  new ButtonModel(0),
  new ButtonModel(63, "", $r('sys.media.ohos_ic_public_arrow_right')),
  new ButtonModel(0),
  new ButtonModel(64, "", $r('sys.media.ohos_ic_public_arrow_down')),
  new ButtonModel(0),
  new ButtonModel(65, "", $r('app.media.zoomin')),
  new ButtonModel(0),
  new ButtonModel(66, "", $r('app.media.zoomout')),
];

export const Test_Camera_Position: ButtonModel[] = [
  new ButtonModel(71,'1'),
  new ButtonModel(72,'2'),
  new ButtonModel(73,'3'),
  new ButtonModel(74,'4'),
  new ButtonModel(75,'5'),
  new ButtonModel(76,'6'),
  new ButtonModel(77,'7'),
  new ButtonModel(78,'', $r('app.media.camera')),
];


export const Test_Setup: ButtonModel[] = [
  new ButtonModel(0, $r('app.string.project')),
  new ButtonModel(81, $r('app.string.on'),$r('app.media.onoff')),
  new ButtonModel(82, $r('app.string.off'),$r('app.media.onoff')),
  new ButtonModel(0, $r('app.string.camera')),
  new ButtonModel(83, $r('app.string.on'),$r('app.media.onoff')),
  new ButtonModel(84, $r('app.string.off'),$r('app.media.onoff')),
];