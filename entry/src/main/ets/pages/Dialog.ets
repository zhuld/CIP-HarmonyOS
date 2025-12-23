import { NormalButton } from "../view/NormalButton";

@CustomDialog
export struct ConfirmDialog{
  controller: CustomDialogController;
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
            // 执行取消回调
          })
          .layoutWeight(1)

        NormalButton({
          label:'确定',
          fontSize:30,
        })
          .onClick(() => {
            this.controller.close();
            // 执行确认回调
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
  controller: CustomDialogController;
  @Prop title: string;

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