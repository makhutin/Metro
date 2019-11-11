//
//  MoreTableView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 26/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit


class MoreTableView: UITableViewController {
    
    var presenter: MoreTableViewPresenterProtocol!
    var configurator = MoreTableViewConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        self.tableView.rowHeight = 40
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return presenter.stationPath.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.stationPath[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1.0 : 80
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StationInfoCell()
        cell.setup(data: presenter.stationPath, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {
            let cell = TransferCell()
            cell.setupTransfer(data: presenter.stationPath, section: section)
            return cell
        }else{
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == presenter.stationPath.count - 1 && !presenter.stationPath.isEmpty{
            let cell = TransferCell()
            cell.setupFullPath(data: presenter.stationPath)
            return cell
        }else{
            return UIView()
        }
    }


}
