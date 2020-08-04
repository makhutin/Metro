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
    func setFromToPoint(buttonType: FromToButtonType, stationID: Int)
    func getAorBPoint(point: MarkerViewWord) -> Int?
    func getColorForLine(withStation id: Int) -> UIColor?
    func getInfoForID(id: Int) -> MetroStationInfo
    
    var getStyleForFromToView: FromToButtonType { get }
    var getStationRoute: [Int] { get }
    var stations: [Int: Station] { get }
    var lineColors: [LineColor] { get }
    var multiStations: [MultiPoint] { get }
    var multiStationsId: [Int] { get }
    var lines: [[LineBetweenStations]] { get }
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
    var lines: [[LineBetweenStations]] {
        return interactor.getLines
    }
    
    var multiStations: [MultiPoint] {
        return interactor.getMultiStations
    }
    
    // all id of multistations
    var multiStationsId: [Int] {
        return multiStations.flatMap { $0.id }
    }
    
    var lineColors: [LineColor] {
        return interactor.getLineColor
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
    
    var stations: [Int: Station] {
        return interactor.getStations
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
    
    func getColorForLine(withStation id: Int) -> UIColor? {
        if let station = stations[id] {
            return lineColors[station.line - 1].color
        }
        return nil
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

    func setFromToPoint(buttonType: FromToButtonType, stationID: Int) {
        self.aPoint = buttonType == .from ? stationID : self.aPoint
        self.bPoint = buttonType == .to ? stationID : self.bPoint
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
    
    var getStyleForFromToView: FromToButtonType {
        var result: FromToButtonType = .to
        switch(aPoint,bPoint){
        case (nil,nil):
            result = .from
        default:
            result = .to
        }
        return result
    }

    func getInfoForID(id: Int) -> MetroStationInfo {
        guard let station = self.stations[id] else {
                return MetroStationInfo(name: "", color: .black, lineNumber: 0, id: 0)
        }

        let color = self.lineColors[station.line - 1]
        return MetroStationInfo(name: station.name[self.language] ?? "", color: color.color, lineNumber: station.line, id: id)
    }
}
