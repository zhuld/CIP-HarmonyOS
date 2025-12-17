import { CrestronClient } from '../../crestron/CrestronClient'
import { VolumeModel } from '../../model/Models'
import { Category } from '../../view/Category'
import { VolumeBar } from '../../view/VolumeBar'
import { Test_Volume_Input, Test_Volume_Output } from './Config'

@Component
export struct SoundComponent {
  @ObjectLink crestronClient : CrestronClient
  @Consume channelDArray : boolean[] = []
  @Consume channelAArray : number[] = []
  @Builder
  VolumeBarContent(volumeList: VolumeModel[]) {
    GridRow({
      columns: volumeList.length,
      gutter: { x: 40, y: 30 }
    }) {
      ForEach(volumeList, (item: VolumeModel) => {
        GridCol({ span: 1 }) {
          VolumeBar({
            name: item.volumeName,
            value: this.channelAArray[item.volumeId],
            mini: item.mini,
            max: item.max,
            checked: this.channelDArray[item.volumeId],
            onMuteAction: (event: TouchEvent) => {
              if (event.type === TouchType.Down) {
                this.crestronClient?.push(item.volumeId)
              } else if (event.type === TouchType.Up) {
                this.crestronClient?.release(item.volumeId)
              }
            },
            onVolumeChanged: (value: number) => {
              this.crestronClient?.level(item.volumeId, value)
            }
          })
        }
      }, (item: VolumeModel) => item.volumeId.toString())
    }
  }

  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Row({ space: 30 }) {
      Category({
        title: '输入', // 动态绑定标题
        subTitle: '请勿随意调整音量',
        contentBuilder: () =>{
          this.VolumeBarContent(Test_Volume_Input)
        }
      })
        .layoutWeight(3)

      Category({
        title: '输出', // 动态绑定标题
        contentBuilder: () =>{
          this.VolumeBarContent(Test_Volume_Output)
        }
      })
        .layoutWeight(1)
    }
    .margin({ bottom: 10, right: 10 ,left:2})
  }
}