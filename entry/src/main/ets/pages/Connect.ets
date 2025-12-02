@Component
export struct ConnectComponent{
  build() {
    Column() {
      Text('中控连接中')
        .fontSize(30)
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