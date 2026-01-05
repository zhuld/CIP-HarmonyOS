import { NormalButton } from "../components/NormalButton";

@CustomDialog
export struct ConfirmDialog{
  private controller: CustomDialogController;
  @Prop title: string;
  @Prop message: string;

  build() {
    Column() {
      Text(this.title)
        .fontSize(30)
        .fontColor($r('app.color.text_color'))
        .layoutWeight(2)
      Row({space:40}) {
        Image($r('app.media.notice'))
          .layoutWeight(1)
          .fillColor($r('app.color.text_color'))
          .draggable(false)
        Text(this.message)
          .fontSize(26)
          .layoutWeight(6)
          .fontColor($r('app.color.text_color'))
          .maxLines(3)
          .textAlign(TextAlign.Start)
      }
      .layoutWeight(6)
      .width('100%')
      Row({space: 40}) {
        NormalButton({
          label:'取消',
          fontSize: 30,
        })
          .onClick(() => {
            this.controller.close();
          })
          .layoutWeight(1)

        NormalButton({
          label:'确定',
          fontSize:30,
        })
          .onClick(() => {
            this.controller.close();
          })
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(3)
    }
    .padding({
      top:10,
      left:30,
      right:30,
      bottom:30
    })
    .width('100%')
    .backgroundColor(Color.Transparent)
    .linearGradient({
      colors:[
        [$r('app.color.catalog_background_1'), 0.2],
        [$r('app.color.catalog_background_2'), 0.2],
        [$r('app.color.catalog_background_1'), 0.24]
      ]
    })
  }
}

@CustomDialog
export struct ProcessDialog {
  private controller: CustomDialogController;
  private timerID: number = -1 // 保存定时器ID用于清理
  @Prop title: string | Resource;
  @Prop autoClose: number = 60000;

  onClose?:() => void
  // 添加生命周期回调
  aboutToAppear() {
    // 设置定时关闭
    this.timerID = setTimeout(() => {
      this.controller.close()
      if(this.onClose){
        this.onClose();
      }
    }, this.autoClose)
  }

  aboutToDisappear() {
    // 清理定时器防止内存泄漏
    if (this.timerID !== -1) {
      clearTimeout(this.timerID)
    }
  }

  build() {
    Column() {
      Text(this.title)
        .fontSize(30)
        .fontColor($r('app.color.text_color'))
        .layoutWeight(2)
      Progress({
        type: ProgressType.Ring,
        value: 0
      })
        .style({
          status: ProgressStatus.LOADING,
          strokeWidth: 10
        })
        .width('100%')
        .layoutWeight(9)
        .color($r('app.color.text_color'))
        .backgroundColor(Color.Transparent)
        .padding(70)
    }
    .padding({
      top: 10,
      left: 30,
      right: 30,
      bottom: 30
    })
    .width('100%')
    .backgroundColor(Color.Transparent)
    .linearGradient({
      colors: [
        [$r('app.color.catalog_background_1'), 0.2],
        [$r('app.color.catalog_background_2'), 0.2],
        [$r('app.color.catalog_background_1'), 0.26]
      ]
    })
  }
}