import { ViewStateConstant } from '../../constants/ViewStateConstant';
import { HomeModelIssueListItemList } from '../../model/HomeModel';
import { CommonTopBar } from '../../views/CommonTopBar';
import { StateComponent } from '../../views/StateComponent';
import { HomeListItemComponent } from './component/HomeListItemComponent';

import { RoutePath } from '../../router/RoutePath';
import { Router } from '../../router/Router';
import { CategoryRouteParams } from '../../router/RouteParams';


@Entry
@Component
export  struct HomePage {
  @State viewState: string = ViewStateConstant.VIEW_STATE_LOADING
  @State isRefreshing: boolean = false
  @State dataList: HomeModelIssueListItemList[] = []
  @State showLoading: boolean = false
  // @Consume @Watch('onTabSelected') homeTabSelected: number


  build() {
    Column(){
      CommonTopBar({title:"首页", backButton: false, alpha: 1 }).align(Alignment.TopStart)
      Stack(){
        StateComponent({
          viewState:this.viewState,
          showSkeleton:true,
          retryCallback:()=>{

          }
        }) {
          Refresh({ refreshing: $$this.isRefreshing, offset: 100, friction: 100 }) {
            List({ space: 10, initialIndex: 0 }) {
              ForEach(this.dataList, (item: HomeModelIssueListItemList, index: number) => {
                ListItem() {
                  HomeListItemComponent({ item: item }).onClick(() => {
                    Router.push(RoutePath.DetailPage, {
                      "id": item?.data?.id,
                      "playUrl": item?.data?.playUrl
                    } as CategoryRouteParams)
                  })
                }
              })
              ListItem() {
                // RefreshFooter({ showFooter: this.showLoading })
              }
            }
            .listDirection(Axis.Vertical) // 排列方向
            .divider({
              strokeWidth: 1,
              color: $r('app.color.color_f5f5f5'),
              startMargin: 10,
              endMargin: 10
            }) // 每行之间的分界线
            .onScrollIndex((firstIndex: number, lastIndex: number) => {

            })
            .onReachEnd(() => {
              this.showLoading = true
              // this.loadNet()
            })
          }
        }
      }.layoutWeight(1)
    }
    .height('100%')
    .width('100%')
  }
}