//
//  AchievementDetailVC.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/18.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit


struct Record {
    var day: Int
    var focusTime: [Int]
}

class AchievementDetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var year: Int!
    var month: Int!
    var recordsOfDay = Dictionary<Int, [PlantRecord]>()
    var dayList: [Int] = []
    var levelList: [Int] = []
    
    override func viewWillAppear(_ animated: Bool) {
        UITool.setBackgroundImage(view, imageName: Theme.getCurrentTheme().backgroundImage)
        self.navigationController?.navigationBar.barTintColor = Theme.getCurrentTheme().themeColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for record in PlantRecord.loadRecords(year: year, month: month) {
            levelList.append(ImageTool.getIndex(focusMinutes: record.minute, timeRange: SystemConstant.FocusRecordRange))
            
            if recordsOfDay.keys.contains(record.day) {
                recordsOfDay[record.day]?.append(record)
            } else {
                recordsOfDay[record.day] = [record]
            }
        }
        dayList = recordsOfDay.keys.sorted()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        setCollectionLayout()
        setTitle()
        
        navigationItem.rightBarButtonItem?.title = LocalizationKey.ARForest.translate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if year == TimeTool.getCurrentYear() && month == TimeTool.getCurrentMonth() {
            let bottomOfSet = CGPoint(x: 0, y: self.collectionView.contentSize.height - self.collectionView.bounds.size.height)
            collectionView.setContentOffset(bottomOfSet, animated: false)
        }
    }
    
    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont(name: "Verdana", size: 22.0)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.text = "\(year!).\(month!)"
        navigationItem.titleView = titleLabel
    }
    
    // 类似AchievementVC中的同名方法
    private func setCollectionLayout() {
        let cellNumPerLine: CGFloat = UIDevice().model == "iPad" ? 4 : 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let space: CGFloat = 8
        let width = (view.frame.size.width - space * (cellNumPerLine + 1)) / cellNumPerLine
        let height = width * IconCell.ratio
        layout.itemSize = CGSize(width: Int(width), height: Int(height))
    }
}

extension AchievementDetailVC: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    // 获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dayList.count
    }
    
    // 返回每个Section中cell的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordsOfDay[dayList[section]]!.count
    }
    
    // 返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let record = recordsOfDay[dayList[indexPath.section]]![indexPath.item]
        let icon = UIImage(named: record.imgName)
        let text = "\(record.minute)\(LocalizationKey.Minute.translate())"
        cell.focusMinutes = record.minute
        cell.drawCell(icon: icon, text: text)
        return cell
    }
    
    // 返回自定义的header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview:UICollectionReusableView!
        
        //分区头
        if kind == UICollectionView.elementKindSectionHeader{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DateHeader", for: indexPath)
            //设置头部标题
            let label = reusableview.viewWithTag(1) as! UILabel
            label.text = TimeTool.dateFormat(month: month, day: dayList[indexPath.section])
        }
        //分区尾
        else if kind == UICollectionView.elementKindSectionFooter{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: "DateFooter", for: indexPath)
        }
        return reusableview
    }
    
    // 处理点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RecordCell else { return }
        let level = ImageTool.getIndex(focusMinutes: cell.focusMinutes, timeRange: SystemConstant.FocusRecordRange)
        if level == 0 {
            alert(message: LocalizationKey.NotificationFailure.translate())
        } else {
            performSegue(withIdentifier: SegueKey.showARForest.rawValue, sender: level)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let level = sender as? Int else { return }
        switch(segue.identifier ?? "") {
        case SegueKey.showARForest.rawValue:
            guard let ARForest = segue.destination as? ARForestController else { return }
            ARForest.level = level
        default:
            return
        }
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: LocalizationKey.Yes.translate(), style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
