/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { CameraComponent } from './Test/Camera';
import { SetupComponent } from './Test/Setup';
import { SoundComponent } from './Test/Sound';
import { VideoComponent } from './Test/Video';
import { HomeComponent } from './Test/Home';
import { PageModel } from '../model/Models';
import { TabButton } from '../view/Views';
import { PageList } from './Test/Config';
import { Head } from './Head';
import { CrestronClient, JoinType } from '../crestron/CrestronClient';
import { ProcessDialog } from './Dialog';
import { common } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';
import { ConnectComponent } from './Connect';


@Entry
@Component
struct Index {
  @State currentPage: number = 0;
  private tabScroller: Scroller = new Scroller();
  private contentScroller: Scroller = new Scroller();
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;
  @State crestronClient: CrestronClient = new CrestronClient();
  @Provide channelDArray : boolean[] = []
  @Provide channelAArray : number[] = []
  private connectTimer: number = 0;
  @State inputMessage: string = 'hello from client';
  @State serverIP: string = '192.168.2.105';
  @State serverPort: number = 41794;
  @State cipId : number = 3
  @State isConnected: boolean = false;
  @State inputValue: number = 0;
  private isDialogOpened : boolean = false
  private lastPage : number = 0

  dialogProcess: CustomDialogController = new CustomDialogController({
    builder: ProcessDialog({
      title: '操作执行中',
    }),
    alignment: DialogAlignment.Center,
    autoCancel:false,
    width: '50%',
    height: '50%',
  });

  async aboutToAppear() {
    this.connectTimer = setInterval(()=>{
      if(this.isConnected){
        this.crestronClient.ping();
      }else{
        this.crestronClient.connect(this.serverIP, this.serverPort, this.cipId);
      }
    },10000)
    this.crestronClient.setupConnectListener((isConnected: boolean) => {
      this.isConnected = isConnected;
      console.info(`[connect] ${this.isConnected}`)
      if(this.isConnected) {
        this.channelDArray = this.crestronClient.channelDArray
        this.channelAArray = this.crestronClient.channelAArray
        this.contentScroller.scrollToIndex(this.lastPage);
        this.currentPage = this.lastPage
      }else {
        this.contentScroller.scrollToIndex(PageList.length);
        this.lastPage = this.currentPage
        this.currentPage = PageList.length
      }
    })

    this.crestronClient.setupStatusListener( (joinType: JoinType, channel:number,value : number) =>{
      if(joinType === JoinType.Digital) {
        this.channelDArray.fill(value === 1 ? true:false, channel, channel)
        if(channel === 1){
          if(value === 1 && !this.isDialogOpened){
            this.dialogProcess.open()
            this.isDialogOpened = true
          }else{
            this.dialogProcess.close()
            this.isDialogOpened = false
          }
        }
      }else if(joinType === JoinType.Analog){
        this.channelAArray.fill(value,channel,channel)
      }
    })
    try {
      const pref = await preferences.getPreferences(this.context, 'network_settings');
      this.serverIP = await pref.get('ip', '192.168.1.10') as string;
      this.serverPort = await pref.get('port', 41794) as number;
      this.cipId = await pref.get('ipId', 3) as number;
    } catch (error) {
      console.error('加载设置失败:', error.message);
    }

    this.crestronClient.connect(this.serverIP, this.serverPort, this.cipId);

    for (let i = 0; i < 500; i++) {
      this.channelDArray.push(false)
    }
    for (let i = 0; i < 100; i++) {
      this.channelAArray.push(0)
    }
    this.contentScroller.scrollToIndex(PageList.length);
    this.currentPage = PageList.length
  }

  aboutToDisappear(): void {
    this.crestronClient.close();
    clearInterval(this.connectTimer)
  }

  build() {
    Column() {
      Head({isConnected:this.isConnected})
        .width('100%')
        .layoutWeight(1)

      Row() {
        // [Start Side_tab_list]
        // 创建分类列表，用于显示页面选项，并通过Scroller实现滚动功能
        List({ scroller: this.tabScroller }) {
          ForEach(PageList, (item: PageModel, index?: number) => {
            TabButton({
              label: item.pageName,
              icon: item.pageIcon,
              checked: (this.currentPage === index ? true : false),
              isEnabled: this.isConnected,
              onTouchAction: (event: TouchEvent) => {
                if (index !== undefined && event.type === TouchType.Down) {
                  this.currentPage = index;
                  this.contentScroller.scrollToIndex(index);
                }
              }
            })
              .padding({
                left:10,
                right:30,
                bottom:20,
                top:10
              })

          },)
        }
        .height('100%')
        .width('14%')
        .scrollBar(BarState.Off)
        //内容
        List({scroller:this.contentScroller}) {
          HomeComponent({ crestronClient: this.crestronClient })
          VideoComponent({ crestronClient: this.crestronClient })
          SoundComponent({ crestronClient: this.crestronClient })
          CameraComponent({ crestronClient: this.crestronClient })
          SetupComponent()
          ConnectComponent()
        }
        .enableScrollInteraction(false)
        .scrollBar(BarState.Off)
        .height('100%')
        .width('86%')
      }
      .width('100%')
      .layoutWeight(10)
    }
    .padding(20)
    .backgroundColor(Color.Transparent)
    .linearGradient({
      angle:180,
      colors:[
        [$r('app.color.background_1'), 0.0],
        [$r('app.color.background_2'), 1],
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

