import { CrestronClient } from '../../crestron/CrestronClient';
import { ButtonModel } from '../../model/Models'
import { Category } from '../../view/Category';
import { InputButton } from '../../view/InputButton';
import { OutputButton } from '../../view/OutputButton';
import { testVideoInput, testVideoOutput  } from './Config'

@ComponentV2
export struct Video2Component {
  @Param @Require crestronClient: CrestronClient
  @Local dragItem: number = 0
  @Local dragOn: boolean[] = []
  @Local scaleValue: number[] = [1.0]

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
              foreColor: this.crestronClient.channelAArray[item.buttonId]
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
        title: testVideoOutput.title, // 动态绑定标题
        icon: testVideoOutput.icon,
        contentBuilder: () => {
          this.OutputContent(testVideoOutput.buttonList, 1)
        } // 动态绑定内容
      })
        .layoutWeight(1)

      Category({
        title: testVideoInput.title, // 动态绑定标题
        icon: testVideoInput.icon,
        subTitle: testVideoInput.subTitle,
        contentBuilder: () => {
          this.InputContent(testVideoInput.buttonList, 2)
        }
      })
        .layoutWeight(2)
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}