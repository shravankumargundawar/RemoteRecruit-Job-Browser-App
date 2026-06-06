//
//  ViewState.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//


enum ViewState<T>{
    case idle,
         loading,
         success(T),
         empty,
         error(String)
}
