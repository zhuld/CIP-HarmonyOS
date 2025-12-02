import { IconButton, } from "../view/Views";
import { ConfirmDialog } from "./Dialog";

@Component
export struct Head {
  @State currentTime: string = ''
  @Prop isConnected: boolean
  private clockId: number = 0

  dialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      title: '操作确认',
      message: '确定要执行此操作吗？'
    }),
    alignment: DialogAlignment.Center,
    autoCancel:false,
    width: '50%',
    height: '50%',
  });
  // 定时器更新逻辑:
  aboutToAppear(): void {
    this.clockId = setInterval(() => {
      let now = new Date();
      this.currentTime =
        `${now.getHours().toString().padStart(2, '0')}:` +
          `${now.getMinutes().toString().padStart(2, '0')}:` +
          `${now.getSeconds().toString().padStart(2, '0')}`;
    }, 1000)
  }

  aboutToDisappear(): void {
    clearInterval(this.clockId);
  }

  build() {
    Row() {
      Text($r('app.string.subTitle'))
        .fontSize(24)
        .layoutWeight(1)
        .textAlign(TextAlign.Start)
        .padding({ left: 20 })
        .fontColor($r('app.color.text_color'))
      Text($r('app.string.Title'))
        .fontSize(26)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.text_color'))
      Row({space: 10,}) {
        Text(this.currentTime)
          .fontSize(24)
          .fontColor($r('app.color.text_color'))
        IconButton({
          icon: this.isConnected? $r('app.media.connection'):$r('app.media.disconnect'),
          checked: !this.isConnected
        })
          .gesture(
            TapGesture({ count: 3 })
              .onAction(() => {
                this.getUIContext().getRouter().pushUrl({
                  url: 'pages/Preferences', // 目标页面路径
                  params: {} // 传递参数（对象形式）
                }).catch((error: Error) => {
                  console.error('路由跳转失败:', error);
                });
              })
          )
          .width(24)
      }
      .layoutWeight(1)
      .padding({ right: 20 })
      .direction(Direction.Rtl)
    }
  }
}