//
//  MetroViewPresenter.swift
//  Metro
//
//  Created by Алексей Махутин on 31.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol MetroViewPresenterProtocol {
    

    func findCurrentPoint() -> MetroDonatOne?
    func touchesEnded()
    func restoreMapToDefault()
    func tapOnDonat(sender: WitchId)
    func pressFromToButton(button: FromToButtonsStyle)
    func getAorBPoint(point: MarkerViewWord) -> Int?
    
    
    var getStyleForFromToView: FromToButtonsStyle { get }
    var getStationRoute: [Int] { get }
    var stations: [Int : MetroStation] { get }
    var multiStations: [MetroMultiStation] { get }
    var text: [Int : String] { get }
    var multiStationsId: [Int] { get }
    var lines: [Int : [LineBetweenStations]] { get }
    var multiCoords: [Int: CGPoint] { get }
    
    
    
}

class MetroViewPresenter: MetroViewPresenterProtocol {
    

    let interactor = MetroViewInteractor()
    weak var view: UIView!
    
    let language = "ru_RU"
    
    var aPoint: Int?
    var bPoint: Int?
    var currentId: Int?
    
    //MARK: Interactor
    var lines: [Int : [LineBetweenStations]] {
        return interactor.getLines
    }
    
    var multiStations: [MetroMultiStation] {
        return interactor.getMultiStations
    }
    
    // all id of multistations
    var multiStationsId: [Int] {
        return multiStations.flatMap { $0.id }
    }
    
    var multiCoords: [Int: CGPoint] {
        var mulitCoords: [Int:CGPoint] = [:]
        for elem in multiStations {
            for point in elem.id {
                mulitCoords.updateValue(elem.coords, forKey: point)
            }
        }
        return mulitCoords
    }
    
    var stations: [Int : MetroStation] {
        return interactor.getStations
    }
    
    //text name of stantions
    var text: [Int : String] {
        return interactor.getText(language: language)
    }
    
    //MARK: Others

    func findCurrentPoint() -> MetroDonatOne? {
        guard let id = currentId, currentId != aPoint && currentId != bPoint else { return nil }
        //if id staitons == id current point
        let result = view.subviews.filter {
            guard let elem = $0 as? MetroDonatOne, elem.id == id else { return false }
            return true
        }
        return result.first as? MetroDonatOne
    }
    

    init(bind: UIView) {
        self.view = bind
    }
    
        
    //MARK: Actions
    
    func touchesEnded() {
        if let station = findCurrentPoint() {
            station.scale()
        }
        currentId = nil
    }
    
    func tapOnDonat(sender: WitchId) {
        currentId = sender.id
    }
    
    //MARK: FromTo view
    func pressFromToButton(button: FromToButtonsStyle) {
        if button == .to { bPoint = currentId }
        if button == .from { aPoint = currentId }
        
    }

    
    func restoreMapToDefault() {
        bPoint = nil
        aPoint = nil
        currentId = nil
    }
    
    //MARK: Get
    var getStationRoute: [Int] {
        guard let a = aPoint, let b = bPoint else {
            return []
        }
        return interactor.findRoute(from: a, to: b)
    }

    func getAorBPoint(point: MarkerViewWord) -> Int? {
        if point == .a {
            return aPoint
        }else{
            return bPoint
        }
    }
    
    var getStyleForFromToView: FromToButtonsStyle {
        var result: FromToButtonsStyle = .to
        switch(aPoint,bPoint){
        case (nil,nil):
            result = .from
        default:
            result = .to
        }
        return result
    }
    
    
    
}
