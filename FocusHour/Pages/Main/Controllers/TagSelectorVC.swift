//
//  GroupSelector.swift
//  MarkUP
//
//  Created by Midrash Elucidator on 2019/4/30.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class TagSelectorVC: UITableViewController {
    
    var tagList = TagTool.getTagList()
    weak var inputTextField: UITextField!
    var okAction: UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addTag(_ tagName: String) {
        let success = TagTool.addTag(name: tagName)
        if success {
            tagList = TagTool.getTagList()
            tableView.reloadData()
        } else {
            let alert = UIAlertController(
                title: LocalizationKey.DuplicateTagName.translate(),
                message: nil,
                preferredStyle: .alert
            )
            alert.addAction(.init(
                title: LocalizationKey.Yes.translate(),
                style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func removeTag(_ tagName: String) {
        let success = TagTool.removeTag(name: tagName)
        if success {
            tagList = TagTool.getTagList()
            tableView.reloadData()
        } else {
            let alert = UIAlertController(
                title: LocalizationKey.CantDeleteTag.translate(),
                message: LocalizationKey.AtLeastOneTag.translate(),
                preferredStyle: .alert
            )
            alert.addAction(.init(
                title: LocalizationKey.Yes.translate(),
                style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
    
}


extension TagSelectorVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagCell
        let tag = tagList[indexPath.row]
        cell.focusTag = tag
        cell.color = TagTool.getColor(ofIndex: indexPath.row)
        cell.setSelected(TagTool.isSelectedTag(tag))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TagTool.selectTag(tagList[indexPath.row])
        tableView.reloadData()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeTag(tagList[indexPath.row])
        }
    }
}


extension TagSelectorVC: UITextFieldDelegate {
    
    @IBAction func showAddTagAlert(_ sender: Any) {
        let alert = UIAlertController(
            title: LocalizationKey.InputTagName.translate(),
            message: "",
            preferredStyle: .alert
        )
        alert.addTextField(configurationHandler: { (textField) in
            textField.delegate = self
            self.inputTextField = textField
            textField.addTarget(self, action: #selector(TagSelectorVC.textFieldDidChanging), for: .editingChanged)
        })
        okAction = .init(
            title: LocalizationKey.Yes.translate(),
            style: .default,
            handler: { (_) in
                self.addTag(self.inputTextField.text!)
        })
        okAction.isEnabled = false;
        alert.addAction(.init(
            title: LocalizationKey.Cancel.translate(),
            style: .cancel))
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        okAction.isEnabled = inputTextField.text != ""
    }
    
    @objc func textFieldDidChanging() {
        okAction.isEnabled = inputTextField.text != ""
    }
}
