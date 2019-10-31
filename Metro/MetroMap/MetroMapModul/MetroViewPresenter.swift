//
//  MetroViewPresenter.swift
//  Metro
//
//  Created by Алексей Махутин on 31.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol MetroViewPresenterProtocol {
    
    
    func getMultiStationsViews() -> [UIView]
    func getTextAndDonatViews() -> [UIView]
    func touchesEnded()
    func restoreMapToDefault()
    var stationPoints: [MetroDonatOne] { get }
    var stationTexts: [TextStationView] { get }
    
    var stations: [Int : MetroStation] { get }
    var text: [Int : String] { get }
    var multiStationsId: [Int] { get }
    var lines: [Int : [LineBetweenStations]] { get }
    var sizeForMarker: CGSize { get }
    
    
    
}

class MetroViewPresenter: MetroViewPresenterProtocol {
    
    let interactor = MetroViewInteractor()
    weak var view: UIView!
    
    let language = "ru_RU"
    let pointSize: CGFloat = 20
    let offsetMapXY: CGFloat = 450
    var widthCoficent: CGFloat { return view.frame.width / 200 }
    var heightCoficent: CGFloat { return view.frame.height / 200 }
    
    var aPoint: Int?
    var bPoint: Int?
    var currentId: Int?
    
    var stationPoints: [MetroDonatOne] = []
    var stationTexts: [TextStationView] = []
    
    //MARK: Interactor
    var lines: [Int : [LineBetweenStations]] {
        return interactor.getLines
    }
    
    var multiStations: [MetroMultiStation] {
        return interactor.getMultiStations
    }
    
    var multiStationsId: [Int] {
        return multiStations.flatMap { $0.id }
    }
    
    var stations: [Int : MetroStation] {
        return interactor.getStations
    }
    
    var text: [Int : String] {
        return interactor.getText(language: language)
    }
    
    var sizeForMarker: CGSize {
        return CGSize(width: pointSize * 2, height: pointSize * 2)
    }
    
    //MARK: Support function
    // Transform x or y to map system coords
    func transformXwithCoficent(x: CGFloat) -> CGFloat {
        return x * widthCoficent + offsetMapXY
    }
    
    func transformYwithCoficent(y: CGFloat) -> CGFloat {
        return y * heightCoficent + offsetMapXY
    }
    
    func findCurrentPoint() -> MetroDonatOne? {
        guard let id = currentId, currentId != aPoint && currentId != bPoint else { return nil }
        let result = stationPoints.filter { $0.id == id }
        return result.first
    }
    

    init(bind: UIView) {
        self.view = bind
    }
    
    //MARK: Create Views function
    //create multistations with coords and coficent
    func getMultiStationsViews() -> [UIView] {
        var result: [UIView] = []
       
        multiStations.forEach{
            let view = MultiStationView()
            let x = transformXwithCoficent(x: $0.coords.x)
            let y = transformYwithCoficent(y: $0.coords.y)
            view.frame.origin = CGPoint(x: x, y: y)
            view.frame.size = CGSize(width: pointSize * 2, height: pointSize * 2)
            view.stationCount = $0.count
            result.append(view)
        }
        return result
    }
    
    func getTextAndDonatViews() -> [UIView] {

        var result: [UIView] = []
        stations.forEach { (arg) in
            let (_, elem) = arg
            let view = MetroDonatOne()
            view.id = elem.id
            let x = transformXwithCoficent(x: elem.coords.x)
            let y = transformYwithCoficent(y: elem.coords.y)
            view.frame.origin = CGPoint(x: x, y: y)
            view.donatColor = elem.color
            view.frame.size = CGSize(width: pointSize, height: pointSize)
            view.delegate = self.view as? MetroDonatOneDelegate
            stationPoints.append(view)
            
            var text = TextStationView()
            text.text = self.text[elem.id] ?? ""
            text.id = elem.id
            text.delegate = self.view as? TextStationViewDelegate

            text = fineTuningText(id: text.id, text: text, view: view)
            text.color = multiStationsId.contains(text.id) ? stations[text.id]!.color : .black
            result.append(text)
            result.append(view)
        }
        return result
    }
    
    
    func fineTuningText(id: Int, text: TextStationView, view: MetroDonatOne) -> TextStationView {
        text.layoutSubviews()
        switch id {
        case 4...8,28,46,63,64,50...53:
            text.frame = CGRect(x: view.frame.midX - text.frame.width - 16, y: view.frame.midY - 10, width: 150, height: 20)
            text.style = .right
        case 57,54,56,45,44:
            text.frame = CGRect(x: view.frame.midX + 6, y: view.frame.midY - 26, width: 150, height: 20)
            text.style = .left
        case 10:
            text.frame = CGRect(x: view.frame.midX - text.frame.width - 14, y: view.frame.midY + 5, width: 150, height: 20)
            text.style = .right
        case 29,9:
            text.frame = CGRect(x: view.frame.midX - text.frame.width - 8, y: view.frame.midY - 26, width: 150, height: 20)
            text.style = .right
        case 43:
            text.frame = CGRect(x: view.frame.midX + 30.3, y: view.frame.midY - 35, width: 150, height: 20)
            text.style = .left
        case 55:
            text.frame = CGRect(x: view.frame.midX - text.frame.width / 2, y: view.frame.midY + 5, width: 150, height: 20)
            text.style = .right
        default:
            text.frame = CGRect(x: view.frame.midX + 15, y: view.frame.midY - 10, width: 150, height: 20)
        }
        return text
    }
    
        
    //MARK: Actions
    
    func touchesEnded() {
        if let station = findCurrentPoint() {
            station.scale()
        }
        currentId = nil
        
    }
    
    func restoreMapToDefault() {
        bPoint = nil
        aPoint = nil
    }

}
