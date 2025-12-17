import { CrestronClient } from '../../crestron/CrestronClient';
import { ButtonModel } from '../../model/Models'
import { Category } from '../../view/Category';
import { InputButton } from '../../view/InputButton';
import { OutputButton } from '../../view/OutputButton';
import { Test_Video_Input, Test_Video_Output  } from './Config'

@Component
export struct Video2Component {
  @ObjectLink crestronClient: CrestronClient
  @Consume channelDArray: boolean[] = []
  @Consume channelAArray: number[] = []
  @State dragItem: number = 0
  @State dragOn: boolean[] = []
  @State scaleValue: number[] = [1.0]

  @Builder
  InputContent(inputList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 40 }
    }) {
      ForEach(inputList, (item: ButtonModel, index?: number) => {
        GridCol({ span: 1 }) {
          InputButton({
            label: item.buttonName,
            icon: item.buttonIcon,
            fontSize: 30,
            foreColor: item.buttonColor,
            onDragAction: (start: boolean) => {
              if (start && index !== undefined) {
                this.dragItem = index + 1
              } else {
                this.dragItem = 0
              }
            }
          })
            .height(80)
        }
      }, (item: ButtonModel) => item.buttonId.toString()
      )
    }.padding({ right: 20, left: 20 })
  }

  @Builder
  OutputContent(outputList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 20 }
    }) {
      ForEach(outputList, (item: ButtonModel, index?: number) => {
        GridCol({ span: 1 }) {
          if (index !== undefined) {
            OutputButton({
              label: item.buttonName,
              icon: item.buttonIcon,
              fontSize: 30,
              foreColor: this.channelAArray[item.buttonId]
            })
              .scale({ x: this.scaleValue[index], y: this.scaleValue[index] })
              .animation({ duration: 100, curve: Curve.EaseInOut })
              .onDrop((event: DragEvent) => {
                this.crestronClient?.level(item.buttonId, this.dragItem)
                this.scaleValue[index] = 1.0
                event.setResult(DragResult.DRAG_SUCCESSFUL);
              })
              .onDragEnter(() => {
                this.scaleValue[index] = 1.1
              })
              .onDragLeave(() => {
                this.scaleValue[index] = 1.0
              })
              .height(80)
          }
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 20, left: 20 })
  }

  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Row({ space: 30 }) {
      Category({
        title: '输出设备', // 动态绑定标题
        contentBuilder: () => {
          this.OutputContent(Test_Video_Output, 1)
        } // 动态绑定内容
      })
        .layoutWeight(1)

      Category({
        title: '输入信号', // 动态绑定标题
        subTitle: '拖拽输入信号到输出设备',
        contentBuilder: () => {
          this.InputContent(Test_Video_Input, 2)
        }
      })
        .layoutWeight(2)
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}