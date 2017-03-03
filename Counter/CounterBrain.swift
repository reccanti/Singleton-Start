//
//  CounterBrain.swift
//  Counter
//
//  Created by jefferson on 9/13/16.
//  Copyright © 2016 tony. All rights reserved.
//

import Foundation

class CounterBrain{
    // MARK: - ivars -
    var total:Int = 0{
        didSet{
           total = checkTotal(total: total)
        }
    }
    // MARK: - initialization -
    init(total:Int){
        self.total = total
        self.total = checkTotal(total: self.total)
    }
    
    // MARK: - public methods -
    func increment(){
        total = total + 1
    }
    
    func decrement(){
        total = total - 1
    }
    
    func clear(){
        total = 0
    }
    
    // MARK: - private helpers -
    private func checkTotal(total:Int)->Int{
        return total > 0 ? total : 0
    }

    
}
