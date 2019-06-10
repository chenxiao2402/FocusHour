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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ARForestView.delegate = self
        ARForestView.debugOptions = [.showWorldOrigin, .showCameras]
        
        let node = SCNNode(geometry: SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0))
        node.position = SCNVector3(0, 0.5, -0.5)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        ARForestView.scene.rootNode.addChildNode(node)
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/mytree.scn")!
        scene.rootNode.enumerateChildNodes({ (node, _) in
            node.worldPosition = SCNVector3(0, -0.8, -2)
            ARForestView.scene.rootNode.addChildNode(node)
        })
        
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
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
