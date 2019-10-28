//
//  ViewController.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let metroView = MetroView()
    let plusButton = UIButton()
    let minusButton = UIButton()
    let tempView = UIView()
    let navigatorBar = UINavigationBar()
    let statusBarView = UIView()
    let morebutton = UIButton()
    var data:[Int] = []
    let riverImage = UIImageView(image: UIImage(named: "neva"))
    let size = 1800
    
    var pathIsDraw = false
    
    
    override func viewDidLoad() {
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        if #available(iOS 13.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light: //light mode
                tempView.backgroundColor = .white
            case .dark: //dark mode
                tempView.backgroundColor = .black
                self.view.backgroundColor = .black
            case .unspecified: //the user interface style is not specified
                tempView.backgroundColor = .white
            @unknown default:
                fatalError("pizdec")
            }
//
        } else {
            tempView.backgroundColor = .white
        }
        super.viewDidLoad()
        buttonsInit()
        screenInit()
        
        riverImage.frame = CGRect(x: size / 4,
                                  y: size / 4,
                                  width: size / 2,
                                  height: size / 2)
        riverImage.layer.opacity = 0.3
        
        for elem in [scrollView,minusButton,plusButton,navigatorBar,morebutton] {
            self.view.addSubview(elem)
        }
        tempView.addSubview(riverImage)
        tempView.addSubview(metroView)
        scrollView.addSubview(tempView)
        self.view.addSubview(statusBarView)
        

        centerZoomMetroView()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if pathIsDraw {
            self.navigationController?.isNavigationBarHidden = false
            return
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func screenInit() {
        metroView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        tempView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        
        metroView.delegate = self
        scrollView.delegate = self
        
        scrollView.frame = self.view.frame
        scrollView.contentSize = tempView.frame.size
        scrollView.isUserInteractionEnabled = true
        scrollView.clipsToBounds = false
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale + 0.5
    }
    
    private func inScrollViewOffsetX(x: CGFloat) -> Bool {
        return (scrollView.contentOffset.x < x && x < scrollView.contentOffset.x + scrollView.frame.width)
    }
    
    private func inScrollViewOffsetY(y: CGFloat) -> Bool {
        return (scrollView.contentOffset.y < y && y < scrollView.contentOffset.y + scrollView.frame.height)
    }
    
    
    private func buttonsInit() {
        //more button sets
        morebutton.frame = CGRect(x: 20,
                                  y: self.view.bounds.height - 100,
                                  width: self.view.frame.width - 40,
                                  height: 50)
        morebutton.setTitle("Показать подробный маршрут", for: .normal)
        morebutton.setTitleColor(UIColor.white, for: .normal)
        morebutton.backgroundColor = UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        morebutton.layer.cornerRadius = morebutton.frame.height / 2
        morebutton.addTarget(self, action: #selector(pressMoreButton), for: .touchUpInside)
        morebutton.layer.opacity = 0
        
        //navigaotBar and button sets
        statusBarView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIApplication.shared.statusBarFrame.height)
        statusBarView.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(pressBack), for: .touchUpInside)
        backButton.sizeToFit()
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        //plus minus button sets
        plusButton.frame = CGRect(x:  self.view.frame.width - 60, y: 94, width: 40, height: 40)
        minusButton.frame = CGRect(x:  self.view.frame.width - 60, y: 140, width: 40, height: 40)
        minusButton.setImage(UIImage(named: "minus"), for: .normal)
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(pressPlus), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(pressMinus), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MoreTableView, segue.identifier == "MoreTableView"{
            vc.data = self.data
        }
    }
    

}


extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return tempView
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        showZoomButtons(show: false)
    }

    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        showZoomButtons(show: true)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
    }
    
    
}

extension ViewController {
    
    @objc func pressPlus() {
        if scrollView.zoomScale < scrollView.maximumZoomScale {
            scrollView.zoomScale += 0.2
        }
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
    }
    
    @objc func pressMinus() {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.zoomScale -= 0.2
        }
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
    }
    
    @objc func pressBack() {
        pathIsDraw = false
        centerZoomMetroView()
        showNavigationBar(show: false)
        metroView.restoreMapToDefault()
        showZoomButtons(show: true)
        showMoreButton(show: false)
    }
    
    @objc func pressMoreButton() {
        self.navigationController?.isNavigationBarHidden = false
        performSegue(withIdentifier: "MoreTableView", sender: (Any).self)
        
    }
}

extension ViewController: MetroVieweDelagate {
    func fromToButtonPress(sender: FromToButtons) {
        
        let x = sender.frame.origin.x  * scrollView.zoomScale
        let x2 = sender.frame.maxX * scrollView.zoomScale
        let y = sender.frame.origin.y * scrollView.zoomScale
        let y2 = sender.frame.maxY * scrollView.zoomScale
        if !inScrollViewOffsetX(x: x) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.x = x - 10
            })
            
        }else if !inScrollViewOffsetX(x: x2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.x = x2 - self.scrollView.frame.width + 10
            })
            
        }
        if !inScrollViewOffsetY(y: y) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.y = y - 10
            })
        }
        else if !inScrollViewOffsetY(y: y2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.y = y2 - self.scrollView.frame.height + 10
            })
        }
    }
    
    
    func drawStationPath(sender: MetroView,data: [Int]) {
        pathIsDraw = true
        centerZoomMetroView()
        showNavigationBar(show: true)
        showZoomButtons(show: false)
        showMoreButton(show: true)
        self.data = data
    }
    
    
}

extension ViewController {
    
    func centerZoomMetroView() {
        UIView.animate(withDuration: 0.6, animations: {
            self.scrollView.zoomScale = self.view.frame.width / (self.tempView.bounds.width  / 2)
            if self.view.bounds.height < self.tempView.frame.height {
                self.scrollView.contentOffset = CGPoint(x: self.tempView.bounds.width  / 4 * self.scrollView.zoomScale,
                                                        y: self.tempView.bounds.height / 4 * self.scrollView.zoomScale - 100)
            }else{
                self.scrollView.contentOffset = CGPoint(x: self.tempView.bounds.width / 4 * self.scrollView.zoomScale,
                                                        y: 0)
            }
            
        })
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
    }
    
    func showNavigationBar(show: Bool) {
        switch show {
        case true:
            UIView.animate(withDuration: 0.6, animations: {
                self.navigationController?.isNavigationBarHidden = false
            })
        case false:
            UIView.animate(withDuration: 0.6, animations: {
                self.navigationController?.isNavigationBarHidden = true
            })
        }
    }
    
    func showZoomButtons(show: Bool) {
        switch show {
        case true:
            UIView.animate(withDuration: 0.6, animations: {
                self.plusButton.layer.opacity = 1
                self.minusButton.layer.opacity = 1
                self.minusButton.layoutIfNeeded()
                self.plusButton.layoutIfNeeded()
            })
        case false:
            UIView.animate(withDuration: 0.6, animations: {
                self.plusButton.layer.opacity = 0
                self.minusButton.layer.opacity = 0
                self.minusButton.layoutIfNeeded()
                self.plusButton.layoutIfNeeded()
            })
        }
    }
    
    func showMoreButton(show: Bool) {
        switch show {
        case true:
            UIView.animate(withDuration: 0.6, animations: {
                self.morebutton.layer.opacity = 1
                self.morebutton.layoutIfNeeded()
            })
        case false:
            UIView.animate(withDuration: 0.6, animations: {
                self.morebutton.layer.opacity = 0
                self.morebutton.layoutIfNeeded()
            })
        }
    }
    
}
