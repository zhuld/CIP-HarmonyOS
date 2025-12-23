import { ButtonModel, Buttons, PageModel, Pages, VolumeModel, Volumes } from "../../model/Models";

export const pages: Pages = new Pages(
  'HarmonyOS-控制面板',
  [
    new PageModel($r('app.string.home'), $r('app.media.home')),
    new PageModel($r('app.string.HDMI'),$r('app.media.HDMI')),
    new PageModel($r('app.string.HDMI'),$r('app.media.HDMI')),
    new PageModel($r('app.string.volume'), $r('app.media.volume')),
    new PageModel($r('app.string.camera'), $r('app.media.camera')),
    new PageModel($r('app.string.setup'), $r('app.media.setup')),
  ]
)

export const testHome1: Buttons = new Buttons('' +
  '系统开关','长按2秒',
  $r('app.media.setup'),
  [
    new ButtonModel(11, '普通会议', $r('app.media.home')),
    new ButtonModel(12, '视频会议', $r('app.media.camera')),
    new ButtonModel(13, '系统关机', $r('app.media.onoff'), $r('sys.color.warning')),
  ]
)

export const testHome2: Buttons = new Buttons(
  '模式选择',
  undefined,
  undefined,
  [
    new ButtonModel(21, '视频会议', $r('app.media.volume')),
    new ButtonModel(22, $r('app.string.camera'), $r('app.media.mute')),
    new ButtonModel(23, $r('app.string.HDMI'), $r('app.media.HDMI')),
    new ButtonModel(24, $r('app.string.volume'), $r('app.media.volume')),
    new ButtonModel(25, $r('app.string.camera'), $r('app.media.camera')),
    new ButtonModel(26, $r('app.string.home'), $r('app.media.home')),
  ]
)

export const testVideoInput: Buttons = new Buttons(
  '输入信号',
  '拖拽输入信号到输出设备',
  $r('app.media.input'),
  [
    new ButtonModel(31, '演讲台',undefined,$r('app.color.input_color_1')),
    new ButtonModel(32, '地插',undefined,$r('app.color.input_color_2')),
    new ButtonModel(33, '墙插',undefined,$r('app.color.input_color_3')),
    new ButtonModel(34, '无线投屏',undefined,$r('app.color.input_color_4')),
    new ButtonModel(35, '电脑',undefined,$r('app.color.input_color_5')),
    new ButtonModel(36, '预留',undefined,$r('app.color.input_color_6')),
    new ButtonModel(37, '地插后',undefined,$r('app.color.input_color_7')),
    new ButtonModel(38, '墙插后',undefined,$r('app.color.input_color_8')),
  ]
)

export const testVideoOutput: Buttons = new Buttons(
  '输出设备',
  undefined,
  $r('app.media.output'),
  [
    new ButtonModel(41, "大屏", $r('app.media.LED')),
    new ButtonModel(42, "返看", $r('app.media.tv')),
    new ButtonModel(43, "监视器", $r('app.media.monitor')),
    new ButtonModel(44, "预留", $r('app.media.HDMI')),
    new ButtonModel(45, "辅流", $r('app.media.auxOutput')),
  ]
)

export const testVolumeInput: Volumes = new Volumes(
  '音频输入',
  '请勿随意调整音量',
  undefined,
  [
    new VolumeModel(51, '无线话筒', -10, -30, 0),
    new VolumeModel(52, '有线话筒', 0, -30, 0),
    new VolumeModel(53, '电脑音频', 0, -30, 0),
  ]
)

export const testVolumeOutput: Volumes = new Volumes(
  '音频输出',
  undefined,
  undefined,
  [
    new VolumeModel(54, "总音量", 0, -30, 6),
  ]
)

export const testCamera: Buttons = new Buttons(
  '摄像头控制',
  undefined,
  undefined,
  [
    new ButtonModel(0),
    new ButtonModel(61, "", $r('app.media.up')),
    new ButtonModel(0),
    new ButtonModel(62, "", $r('app.media.left')),
    new ButtonModel(0),
    new ButtonModel(63, "", $r('app.media.right')),
    new ButtonModel(0),
    new ButtonModel(64, "", $r('app.media.down')),
    new ButtonModel(0),
    new ButtonModel(65, "", $r('app.media.zoomin')),
    new ButtonModel(0),
    new ButtonModel(66, "", $r('app.media.zoomout')),
  ]
)

export const testPosition: Buttons = new Buttons(
  '预置位',
  '自动跟踪',
  undefined,
  [
    new ButtonModel(71,'1'),
    new ButtonModel(72,'2'),
    new ButtonModel(73,'3'),
    new ButtonModel(74,'4'),
    new ButtonModel(75,'5'),
    new ButtonModel(76,'6'),
    new ButtonModel(77,'7'),
    new ButtonModel(78,'8'),
    new ButtonModel(79,'全景'),
  ],
  70
)

export const testSetup: Buttons = new Buttons(
  '设备开关',
  '长按2秒',
  $r('app.media.onoff'),
  [
    new ButtonModel(0, $r('app.string.project')),
    new ButtonModel(81, $r('app.string.on'),$r('app.media.onoff')),
    new ButtonModel(82, $r('app.string.off'),$r('app.media.onoff')),
    new ButtonModel(0, $r('app.string.camera')),
    new ButtonModel(83, $r('app.string.on'),$r('app.media.onoff')),
    new ButtonModel(84, $r('app.string.off'),$r('app.media.onoff')),
  ]
)