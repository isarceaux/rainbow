//
//  ChecklistTableViewController.swift
//  rainbow
//
//  Created by David Okun IBM on 5/3/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChecklistTableViewCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView?
    @IBOutlet weak var itemLabel: UILabel?
    @IBOutlet weak var minutesFoundLabel: UILabel?
    @IBOutlet weak var checkboxView: UIImageView?
}

class ChecklistTableViewController: UITableViewController {
    var gameConfigObjects: [ObjectConfig]?
    
    var currentGame: ScoreEntry? {
        do {
            let savedGame = try ScoreEntry.ClientPersistence.get()
            return savedGame
        } catch {
            return nil
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            let objects = try GameConfig.load()
            gameConfigObjects = objects.sorted { $0.name < $1.name }
            tableView.reloadData()
        } catch {
            SVProgressHUD.showError(withStatus: "Could not load game configuration")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let gameConfigObjects = gameConfigObjects else {
            return 0
        }
        return gameConfigObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: "ChecklistTableViewCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistTableViewCell", for: indexPath) as? ChecklistTableViewCell else {
            return defaultCell
        }
        guard let configObject = gameConfigObjects?[indexPath.row] else {
            return defaultCell
        }
        cell.iconView?.image = configObject.getColorImage()
        cell.itemLabel?.text = configObject.name
        cell.checkboxView?.layer.borderColor = UIColor.RainbowColors.blue.cgColor
        cell.checkboxView?.layer.borderWidth = 0.3
        cell.checkboxView?.image = nil
        cell.minutesFoundLabel?.text = "-"
        guard let objects = currentGame?.objects else {
            return cell
        }
        let filteredObjects = objects.filter { $0.name == configObject.name }
        if let first = filteredObjects.first {
            cell.checkboxView?.image = #imageLiteral(resourceName: "blueCheckmark")
            guard let currentStartDate = currentGame?.startDate else {
                return cell
            }
            cell.minutesFoundLabel?.text = GameTimer.getTimeFoundString(startDate: currentStartDate, objectTimestamp: first.timestamp)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("test console")
        // print(UserDefaults.standard.object(forKey: "lastPlace"))
        let readPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("lastPlace")
        let image    = UIImage(contentsOfFile: (readPath?.path)!)
        let imageController = ImageViewController()
        imageController.imageView.image = image
        present(imageController, animated: true) {
        }
    }
}


class ImageViewController : UIViewController {
    var imageView: UIImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: view.bounds.size.width - 100, y: 0, width: 100, height: 50))
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor.black

        imageView.frame = view.bounds
        view.addSubview(imageView)
        button.addTarget(self, action: #selector(onTapClose), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
    }
    @objc func onTapClose(){
        dismiss(animated: true, completion: nil)
    }
    
}
