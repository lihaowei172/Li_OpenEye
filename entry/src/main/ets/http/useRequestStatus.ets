import { ViewStateConstant } from '../constants/ViewStateConstant';

import axios from '@ohos/axios';
import { CommonType } from '../model/typeAlias/TypeAlias';

export interface LoadStateResult {
  promise: <T>(requestPromise: Promise<T>, showLoadingState?: boolean) => Promise<T>
}

function updateViewState(state: string, stateCallback?: (state: string) => void) {
  stateCallback?.(state)
}

function run<T>(requestPromise:Promise<T>, checkResult: boolean, showLoadingState?: boolean, stateCallback?: (state: string) => void):Promise<T>{
  return new Promise<T>((resolve,reject)=>{
    requestPromise.then((res)=>{
      resolve(res)
    }).catch((error:CommonType)=>{
      reject(error)
    })
  })
}
function useRequestStatus(stateCallback?: (state: string) => void, checkResult: boolean = false): LoadStateResult {
  return {
    promise: (requestPromise, showLoadingState) => run(requestPromise, checkResult, showLoadingState, stateCallback)
  };
}

export default useRequestStatus;


