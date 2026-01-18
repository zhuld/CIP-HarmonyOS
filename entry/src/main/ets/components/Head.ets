import { BatteryStatusComponent } from "./Battery";
import { IconButton } from "./IconButton";

@ComponentV2
export struct Head {
  @Local currentTime: string = ''
  @Param isConnected: boolean = false
  @Param messageT: string = ''
  @Param messageR: string = ''
  @Param title: string | Resource = ''
  private clockId: number = 0
  @Param fontSize: number = 20

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
      Text(this.title)
        .fontSize(this.fontSize)
        .layoutWeight(1)
        .padding({ left: 10 })
        .textAlign(TextAlign.Start)
        .fontColor($r('app.color.text_color'))
      Row({ space: 10 }) {
        BatteryStatusComponent({sizeHeight:this.fontSize})
        IconButton({
          icon: this.isConnected ? $r('app.media.connection') : $r('app.media.disconnect'),
          checked: !this.isConnected
        })
          .gesture(
            TapGesture({ count: 3 })
              .onAction(() => {
                this.getUIContext().getRouter().pushUrl({
                  url: 'pages/Preferences', // 目标页面路径
                }).catch((error: Error) => {
                  console.error('路由跳转失败:', error);
                });
              })
          )
          .width(this.fontSize)
        Text(this.currentTime)
          .fontSize(this.fontSize)
          .fontColor($r('app.color.text_color'))
        Text(this.messageT)
          .fontSize(this.fontSize)
          .fontColor($r('app.color.text_color'))
          .width(120)
        Text(this.messageR)
          .fontSize(this.fontSize)
          .fontColor($r('app.color.text_color'))
          .width(120)
      }
      .layoutWeight(1)
      .direction(Direction.Rtl)
    }
  }
}