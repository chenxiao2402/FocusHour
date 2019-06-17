//
//  ARForestController.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/10.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARForestController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var ARForestView: ARSCNView!
    var level = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ARForestView.delegate = self
        addForestNode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        ARForestView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        ARForestView.session.pause()
    }
    
    @IBAction func quit(_ sender: Any) {
        dismiss()
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
}

extension ARForestController {
    
    private func addForestNode() {
        guard let scene = SCNScene(named: "art.scnassets/Tree-\(level).scn") else { return }
        scene.rootNode.enumerateChildNodes({ (node, _) in
            node.scale = SCNVector3(0.25, 0.25, 0.25)
            node.position = SCNVector3(0, -1.5, -2)
            ARForestView.scene.rootNode.addChildNode(node)
        })
    }
    
    private func addForestNodes() {
//        for (i, position) in loadPositions().enumerated() {
//            let scene = SCNScene(named: "art.scnassets/Tree-\(level).scn")!
//            scene.rootNode.enumerateChildNodes({ (node, _) in
//                node.scale = SCNVector3(0.3, 0.3, 0.3)
//                node.position = position
//                ARForestView.scene.rootNode.addChildNode(node)
//            })
//        }
    }
    
    private func loadPositions() -> [SCNVector3] {
        let treeNum = 3
        let treeNumPerLine = Int(ceil(sqrt(Double(treeNum))))
        let distanceBetweenTrees = 2.0
        let xOffset = treeNumPerLine % 2 == 1 ? 0.0 : distanceBetweenTrees / 2
        let zOffset = -1.0

        var result: [SCNVector3] = []
        for i in 0..<treeNum {
            let xIndex = Double(i % treeNumPerLine)
            let zIndex = Double(i / treeNumPerLine)
            let y = -1.5
            let z = -zIndex * distanceBetweenTrees + zOffset
            let x = pow(-1.0, xIndex) * xIndex * distanceBetweenTrees + xOffset
            result.append(SCNVector3(x, y, z))
        }
        return result
    }
}
