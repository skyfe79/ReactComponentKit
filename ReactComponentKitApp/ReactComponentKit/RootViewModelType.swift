//
//  RootComponentViewModelType.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 8. 1..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import BKRedux
import BKEventBus
import RxSwift

public class RootViewModelType: ViewModelType {
    public let token: Token
    public let eventBus: EventBus<ComponentEvent>
    
    public override init() {
        self.token = Token()
        self.eventBus = EventBus(token: self.token)
        super.init()
        
        eventBus.on { [weak self] (event) in
            guard let strongSelf = self else { return }
            switch event {
            case let .dispatch(action):
                Observable.just(action).bind(to: strongSelf.rx_action).disposed(by: strongSelf.disposeBag)
            default:
                break
            }
        }
    }
}
