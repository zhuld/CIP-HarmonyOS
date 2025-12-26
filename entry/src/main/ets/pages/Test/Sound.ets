import { CrestronClient } from '../../crestron/CrestronClient'
import { VolumeModel } from '../../models/Models'
import { Category } from '../../components/Category'
import { VolumeBar } from '../../components/VolumeBar'
import { testVolumeInput, testVolumeOutput } from './Config'

@ComponentV2
export struct SoundComponent {
  @Param @Require crestronClient : CrestronClient
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
            value: this.crestronClient.channelAArray[item.volumeId],
            min: item.mini,
            max: item.max,
            checked: this.crestronClient.channelDArray[item.volumeId],
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
        title: testVolumeInput.title, // 动态绑定标题
        subTitle: testVolumeOutput.subTitle,
        contentBuilder: () =>{
          this.VolumeBarContent(testVolumeInput.volumeList)
        }
      })
        .layoutWeight(3)

      Category({
        title: testVolumeOutput.title, // 动态绑定标题
        subTitle: testVolumeOutput.subTitle,
        icon: testVolumeOutput.icon,
        contentBuilder: () =>{
          this.VolumeBarContent(testVolumeOutput.volumeList)
        }
      })
        .layoutWeight(1)
    }
    .margin({ bottom: 10, right: 10 ,left:2})
  }
}