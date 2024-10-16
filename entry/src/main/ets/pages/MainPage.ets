import { CommonConstants } from '../constants/CommonConstants';
import ItemTab from '../model/ItemTab';
import MainViewModel from '../model/MainViewModel';
import { FindPage } from './find/FindPage';
import { HomePage } from './home/HomePage';
import { HotPage } from './hot/HotPage';
import { MinePage } from './mine/MinePage';


/**
 * 欢迎页
 */
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';//装饰器和ui相关
  @State selectedIndex:number=0

  build() {
    Column(){
      Tabs({
        index:this.selectedIndex,
        barPosition:BarPosition.End
      }){
        TabContent(){
          HomePage()
        } .tabBar(this.TabBottom(MainViewModel.tabTitle[0],0))
        TabContent(){
          FindPage()
        } .tabBar(this.TabBottom(MainViewModel.tabTitle[1],1))
        TabContent(){
          HotPage()
        } .tabBar(this.TabBottom(MainViewModel.tabTitle[2],2))
        TabContent(){
          MinePage()
        } .tabBar(this.TabBottom(MainViewModel.tabTitle[3],3))
      }.onChange((index:number)=>{
        this.selectedIndex=index
      })
    }
    .height('100%')
    .width('100%')
  }


  @Builder TabBottom(item:ItemTab,index:number){
    Column(){
      Image(this.selectedIndex===index?item.imageActivated:item.imageOriginal)
        .height($r('app.float.tab_image_size'))
        .width($r('app.float.tab_image_size'))
        .margin({
          top:$r('app.float.tab_margin_top'),
          bottom:$r('app.float.tab_margin_bottom')
        })
      Text(item.title)
        .fontSize($r('app.float.tab_text_font_size'))
        .height($r('app.float.tab_text_height'))
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .fontWeight(CommonConstants.TAB_ITEM_FONT_WEIGHT)
        .fontColor(this.selectedIndex===index?$r('app.color.color_red'):Color.Gray)
        .textAlign(TextAlign.Center)
        .margin({
          bottom:$r('app.float.tab_text_margin_bottom')
        })
    }.justifyContent(FlexAlign.Center)
    .height(CommonConstants.FULL_HEIGHT_PERCENT)
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .backgroundColor($r("app.color.color_f5f5f5"))
  }
}