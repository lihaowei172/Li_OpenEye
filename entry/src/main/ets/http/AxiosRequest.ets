import { AxiosRequestHeaders, AxiosResponse } from '@ohos/axios'
import { AxioshttpRequest, HttpRequestConfig } from './AxioshttpRequest'


const axiosClient = new AxioshttpRequest({
  baseURL: "/api",
  timeout: 10 * 1000,
  checkResultCode: false,
  headers: {
    'Content-Type': 'application/json'
  } as AxiosRequestHeaders,
  interceptorHooks: {
    requestInterceptor: async (config) => {
      axiosClient.config.showLoading = config.showLoading
      return config;
    },
    requestInterceptorCatch: (err) => {
      return err;
    },
    responseInterceptor: (response: AxiosResponse) => {
      //优先执行自己的请求响应拦截器，在执行通用请求request的
      if (response.status === 200) {
        let config = response.config as HttpRequestConfig
        const checkResultCode = config.checkResultCode
        if (checkResultCode && response.data.errorCode != 0) {
          return Promise.reject(response)
        }
        return Promise.resolve(response.data);
      } else {
        return Promise.reject(response);
      }
    },
    responseInterceptorCatch: (error) => {
      /*if (axiosClient.config.showLoading) {
        hideLoadingDialog()
      }
      LogUtils.error("网络请求响应异常", error.toString())
      errorHandler(error);*/
      return Promise.reject(error);
    },
  }
})

export default axiosClient








