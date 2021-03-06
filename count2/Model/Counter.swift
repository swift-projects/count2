//
//  Counter.swift
//  count2
//
//  Created by ST20591 on 2018/01/09.
//  Copyright © 2018年 ha1f. All rights reserved.
//

import Foundation
import RxSwift

final class Counter {
    private(set) var value = 0 {
        didSet {
            observer?(value)
        }
    }
    
    var timer: Timer?
    
    private var observer: ((Int) -> ())?
    
    func observe(_ observer: @escaping (Int) -> ()) {
        self.observer = observer
        
        // Pass initial value
        observer(value)
    }
    
    func countWithTimer(timeInterval: TimeInterval) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            self?.count()
        }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetObserver() {
        observer = nil
    }
    
    func resetCounter() {
        value = 0
    }
    
    func count() {
        value += 1
    }
    
    deinit {
        invalidateTimer()
    }
}
