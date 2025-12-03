import { Category } from "../view/Views"

@Component
export struct ConnectComponent{
  @Prop serverIP: string
  @Prop serverPort: number
  @Prop ipId: number
  @Prop isConnected: boolean
  @Builder
  ConnectContent(){
    Column() {
      Text(`中控IP：${this.serverIP}\n端口：${this.serverPort}\nID：${this.ipId}`)
        .fontSize(36)
        .layoutWeight(1)
        .fontColor($r('app.color.text_color'))
      Progress({
        type: ProgressType.Ring,
        value: 0
      })
        .style({
          status: this.isConnected ? ProgressStatus.PROGRESSING : ProgressStatus.LOADING,
          strokeWidth: 10
        })
        .width('100%')
        .layoutWeight(1)
        .color($r('app.color.text_color'))
        .backgroundColor(Color.Transparent)
        .padding(50)
    }
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: '中控连接中', // 动态绑定标题
        contentBuilder: () =>{
          this.ConnectContent()
        }
      })
        .layoutWeight(1)
    }
    .margin({ bottom: 10, right: 10 ,left:2})
  }
}

