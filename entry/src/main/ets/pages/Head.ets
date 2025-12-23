import { BatteryStatusComponent } from "../view/Battery";
import { IconButton } from "../view/IconButton";
import { ConfirmDialog } from "./Dialog";

@ComponentV2
export struct Head {
  @Local currentTime: string = ''
  @Param isConnected: boolean = false
  @Param messageT: string = ''
  @Param messageR: string = ''
  @Param title: string | Resource = ''
  //@Param subTitle: string | Resource = ''
  private clockId: number = 0
  @Param sizeHeight: number = 20
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      title: '操作确认',
      message: '确定要执行此操作吗？'
    }),
    alignment: DialogAlignment.Center,
    autoCancel: false,
    width: '50%',
    height: '50%',
  });

  // 定时器更新逻辑:
  aboutToAppear(): void {
    this.clockId = setInterval(() => {
      let now = new Date();
      this.currentTime =
        `${now.getHours().toString().padStart(2, '0')}:` +
          `${now.getMinutes().toString().padStart(2, '0')}` ;
    }, 1000)
  }

  aboutToDisappear(): void {
    clearInterval(this.clockId);
  }

  build() {
    Row() {
      // Text(this.subTitle)
      //   .fontSize(this.sizeHeight)
      //   .layoutWeight(1)
      //   .textAlign(TextAlign.Start)
      //   .padding({ left: 10 })
      //   .fontColor($r('app.color.text_color'))
      Text(this.title)
        .fontSize(this.sizeHeight)
        .layoutWeight(1)
        .padding({ left: 10 })
        .textAlign(TextAlign.Start)
        .fontColor($r('app.color.text_color'))
      Row({ space: 10 }) {
        BatteryStatusComponent({sizeHeight:this.sizeHeight})
        IconButton({
          icon: this.isConnected ? $r('app.media.connection') : $r('app.media.disconnect'),
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
          .width(this.sizeHeight)
        Text(this.currentTime)
          .fontSize(this.sizeHeight)
          .fontColor($r('app.color.text_color'))
        Text(this.messageT)
          .fontSize(this.sizeHeight)
          .fontColor($r('app.color.text_color'))
          .width(120)
        Text(this.messageR)
          .fontSize(this.sizeHeight)
          .fontColor($r('app.color.text_color'))
          .width(120)
      }
      .layoutWeight(1)
      .direction(Direction.Rtl)
    }
  }
}