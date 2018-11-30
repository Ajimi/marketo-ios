//
//  ViewModel.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class ViewModel {
    func emitUiState<T>(
        showProgress: Bool = false,
        showError: Event<String>? = nil,
        showSuccess: Event<T>? = nil // TODO Change this To Model
        ) -> UiState<T> {
        
        return UiState<T>(showProgress: showProgress, showError: showError,showSuccess: showSuccess)
    }
}

struct UiState<T> {
    var showProgress: Bool
    var showError: Event<String>?
    var showSuccess: Event<T>?
}
