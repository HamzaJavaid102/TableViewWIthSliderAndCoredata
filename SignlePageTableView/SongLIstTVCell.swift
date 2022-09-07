//
//  SongLIstTVCell.swift
//  SignlePageTableView
//
//  Created by Hamza on 19/08/2022.
//

import UIKit

class SongLIstTVCell: UITableViewCell {

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var catLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.black.cgColor
            bgView.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var dot: UIView! {
        didSet {
            dot.layer.cornerRadius = 8
        }
    }
    
    static var identifier = "SongLIstTVCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellActionButtonLabel?.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSongsCellData(song: Songs) {
        bgView.backgroundColor = .cyan.withAlphaComponent(0.2)
        titleLbl.text = song.song_title
        catLbl.text = song.song_cate
        idLbl.text = "\(song.song_id)"
        dateLbl.text = "\(String(describing: song.date_received!.relativeDate()))"
        song.has_been_viewed ? (dot.isHidden = false) :  (dot.isHidden = true)
    }
    
    func setupArchiveCellData(song: ArchivedSongs) {
        bgView.backgroundColor = .secondaryLabel.withAlphaComponent(0.2)
        titleLbl.text = song.song_title
        catLbl.text = song.song_cate
        idLbl.text = "\(song.song_id)"
        dateLbl.text = "\(String(describing: song.date_received!.relativeDate()))"
        song.has_been_viewed ? (dot.isHidden = false) :  (dot.isHidden = true)
    }
    
}

extension UITableViewCell {
    var cellActionButtonLabel: UILabel? {
        superview?.subviews
            .filter { String(describing: $0).range(of: "UISwipeActionPullView") != nil }
            .flatMap { $0.subviews }
            .filter { String(describing: $0).range(of: "UISwipeActionStandardButton") != nil }
            .flatMap { $0.subviews }
            .compactMap { $0 as? UILabel }.first
    }
}
