//
//  SongList.swift
//  VKplayer
//
//  Created by Артём Горюнов on 19.10.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit

var songListVC = SongList()

class SongList: UIViewController {
    
    static var songList = SongList()
    var thisSong = 0
    
    @IBAction func backVC() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var songListTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songListVC = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector (backVC))
        navigationItem.title = "Song List"
        
        songListTableView.delegate = self
        songListTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        songListTableView.reloadData()
    }
}

extension SongList: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongArchiver.main.songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as? EmptyTableViewCell {
            let song = SongArchiver.main.songs[indexPath.row]
            cell.SongName.text = "\(song.artist) - \(song.song)"
            print(song)
            thisSong = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? Player {
            vc.playerContainer = SongArchiver.main.songs[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
//            let audioPath = Bundle.main.path(forResource: SongArchiver.main.songs[indexPath.row] as? String, ofType: "mp3")
            print(indexPath.row)
            thisSong = indexPath.row
        }
    }
}
