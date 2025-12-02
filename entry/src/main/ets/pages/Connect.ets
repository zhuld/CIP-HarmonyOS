@Component
export struct ConnectComponent{
  @Prop serverIP: string
  @Prop serverPort: number
  @Prop ipId: number
  build() {
    Column() {
      Text(`中控连接中\n\n中控IP：${this.serverIP}\n端口：${this.serverPort}\nID：${this.ipId}` )
        .fontSize(36)
        .layoutWeight(1)
      LoadingProgress()
        .width('100%')
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({
      right: '16%',
      bottom: '10%'
    })
  }
}