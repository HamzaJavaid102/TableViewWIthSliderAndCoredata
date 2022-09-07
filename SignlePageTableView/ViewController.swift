//
//  ViewController.swift
//  SignlePageTableView
//
//  Created by Hamza on 19/08/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLbl: UILabel!
    
    var selectedSegment = 0 {
        didSet {
            tableView.reloadData()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addSongstoCoreData()
        CoreData_functions.fetchSongsList(){ count in
            self.showEmptyMsg(count)
        }
        
        tableView.register(UINib(nibName: SongLIstTVCell.identifier, bundle: nil), forCellReuseIdentifier: SongLIstTVCell.identifier)
        
    }

    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        selectedSegment = segment.selectedSegmentIndex
        switch segment.selectedSegmentIndex {
        case 0:
            CoreData_functions.fetchSongsList(){ count in
                self.showEmptyMsg(count)
            }
        case 1:
            CoreData_functions.fetchArchiveList(){ count in
                self.showEmptyMsg(count)
            }
        default:
            print("")
        }
    }
    
    func addSongstoCoreData() {
        let currentDate  = Date()
        saveSongs(title: "Song 1", id: 001, cate: "Songs", deleteDate: currentDate, receivedDate: currentDate, haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 2", id: 002, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-1), haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 3", id: 003, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-2), haseViewd: true, date_archived: currentDate)
        saveSongs(title: "Song 4", id: 004, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-3), haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 5", id: 005, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-4), haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 6", id: 006, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-5), haseViewd: true, date_archived: currentDate)
        saveSongs(title: "Song 11", id: 007, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-6), haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 7", id: 008, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-7), haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 8", id: 009, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-8), haseViewd: true, date_archived: currentDate)
        saveSongs(title: "Song 9", id: 0010, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-9), haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 10", id: 0011, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-10), haseViewd: false, date_archived: currentDate)
        saveSongs(title: "Song 12", id: 0012, cate: "Songs", deleteDate: currentDate, receivedDate: previousDate(-11), haseViewd: true, date_archived: currentDate)
    }
    
    func previousDate(_ day: Int) -> Date {
       return (Calendar.current.date(byAdding: .day, value: day, to: Date()))!
    }
    
    func saveSongs(title: String, id: Int, cate: String, deleteDate: Date, receivedDate: Date, haseViewd: Bool,date_archived: Date)
    {
        let taskDict = [Entity_Attributes.song_title: title, Entity_Attributes.song_id: id, Entity_Attributes.song_cate: cate, Entity_Attributes.date_deleted: deleteDate,Entity_Attributes.date_received: receivedDate, Entity_Attributes.has_been_viewed:haseViewd,Entity_Attributes.date_archived: date_archived] as [String:Any]
        CoreData_functions.saveSongsData(valuesForKeys: taskDict)
    }
    
    func saveArchives(title: String, id: Int, cate: String, deleteDate: Date, receivedDate: Date, haseViewd: Bool, date_archived: Date)
    {
        let taskDict = [Entity_Attributes.song_title: title, Entity_Attributes.song_id: id, Entity_Attributes.song_cate: cate, Entity_Attributes.date_deleted: deleteDate,Entity_Attributes.date_received: receivedDate, Entity_Attributes.has_been_viewed:haseViewd,Entity_Attributes.date_archived: date_archived] as [String:Any]
        CoreData_functions.saveArchivedSongData(valuesForKeys: taskDict)
    }
    
    func showEmptyMsg(_ count: Int) {
        count == 0 ? (self.emptyLbl.isHidden = false) : (self.emptyLbl.isHidden = true)
        self.tableView.reloadData()
    }
    
    func archiveSongs(_ song: Songs,index: Int) {
        saveArchives(title: song.song_title ?? "", id: Int(song.song_id), cate: song.song_cate ?? "", deleteDate: Date(), receivedDate: song.date_received!, haseViewd: song.has_been_viewed, date_archived: song.date_archived!)
        CoreData_functions.deleteSongData(id: index)
        CoreData_functions.fetchSongsList { count in
            self.showEmptyMsg(count)
        }
    }
    
    func restoreArchivedSong(_ song: ArchivedSongs,index: Int) {
        saveSongs(title: song.song_title ?? "", id: Int(song.song_id), cate: song.song_cate ?? "", deleteDate: Date(), receivedDate: song.date_received!, haseViewd: song.has_been_viewed, date_archived:song.date_archived!)
        CoreData_functions.deleteArchivedSongData(id: index)
        CoreData_functions.fetchArchiveList() { count in
            self.showEmptyMsg(count)
        }
    }
    
    func deleteSong(_ index: Int) {
        CoreData_functions.deleteSongData(id: index)
        CoreData_functions.fetchSongsList { count in
            self.showEmptyMsg(count)
        }
    }
    
    func deleteArchivedSong(_ index: Int) {
        CoreData_functions.deleteArchivedSongData(id: index)
        CoreData_functions.fetchArchiveList() { count in
            self.showEmptyMsg(count)
        }
    }
    
    //MARK: Play Song Function
    func playSong(songId: Int, cateId: String) {
        print("play song here ")
        print("songID", songId)
    }
    
    @objc func platBtnTappend(_ sender: UIButton) {
        if selectedSegment == 0 {
            let song:Songs = CoreData_functions.SONGSLIST[sender.tag]
            playSong(songId: Int(song.song_id), cateId: song.song_cate!)
        } else {
            let song:ArchivedSongs = CoreData_functions.ARCHIVES[sender.tag]
            playSong(songId: Int(song.song_id), cateId: song.song_cate!)
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 0 {
            return CoreData_functions.SONGSLIST.count
        } else {
            return CoreData_functions.ARCHIVES.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongLIstTVCell.identifier, for: indexPath) as! SongLIstTVCell

        (selectedSegment == 0) ? (cell.setupSongsCellData(song: CoreData_functions.SONGSLIST[indexPath.row])) : (cell.setupArchiveCellData(song: CoreData_functions.ARCHIVES[indexPath.row]))
        cell.playBtn.tag = indexPath.row
        cell.playBtn.addTarget(self, action: #selector(platBtnTappend), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let archiveAction = UIContextualAction(style: .normal, title: "Archive") { [self]  (contextualAction, view, boolValue) in
            archiveSongs(CoreData_functions.SONGSLIST[indexPath.row], index: indexPath.row)
           
       }
        archiveAction.image = UIImage(systemName: "flag")
        archiveAction.backgroundColor = .orange
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") {  (contextualAction, view, boolValue) in
           
            let alert = UIAlertController(title: "", message: "This action cannot be undone", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Delete Song", style: .destructive, handler: { action in
                (self.selectedSegment == 0) ? (self.deleteSong(indexPath.row)) : (self.deleteArchivedSong(indexPath.row))
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                tableView.reloadData()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        
        let restoreAction = UIContextualAction(style: .normal, title: "Restore") {  (contextualAction, view, boolValue) in
            self.restoreArchivedSong(CoreData_functions.ARCHIVES[indexPath.row], index: indexPath.row)
        }
        restoreAction.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        restoreAction.title = "Restore"
        restoreAction.backgroundColor = .blue
        
        var actions = [UIContextualAction]()
        
        selectedSegment == 0 ? (actions = [archiveAction,deleteAction]) : (actions = [deleteAction,restoreAction])
        
       let swipeActions = UISwipeActionsConfiguration(actions: actions)

       return swipeActions
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedSegment == 0 {
            let song:Songs = CoreData_functions.SONGSLIST[indexPath.row]
            playSong(songId: Int(song.song_id), cateId: song.song_cate!)
        } else {
            let song:ArchivedSongs = CoreData_functions.ARCHIVES[indexPath.row]
            playSong(songId: Int(song.song_id), cateId: song.song_cate!)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        91
    }
}

