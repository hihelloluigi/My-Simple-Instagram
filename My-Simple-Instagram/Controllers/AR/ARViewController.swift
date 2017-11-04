//
//  ARViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 04/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

@available(iOS 11.0, *)
class ARViewController: UIViewController {

    //MARK:- Properties
    var sceneView: ARSCNView!
    var image: UIImage!

//    var planes = [OverlayPlane]()
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dynamically set ARSCNView
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        //MARK:- Debug session
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // Set the view's delegate
//        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        registerTapGestureRecognizers()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        //Show orizontal planes that app find around you
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    //MARK:- Helpers
    private func registerTapGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func tapped(recognizer: UIGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            print("Scene is not a SCNView")
            return
        }
        let touchLocation = recognizer.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if !hitTestResult.isEmpty {
            guard let hitResult = hitTestResult.first else {
                return
            }
            addBox(hitResult: hitResult)
        }
    }
    private func addBox(hitResult: ARHitTestResult) {
        
        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = image
        boxGeometry.materials = [imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial]
        let cube = SCNNode(geometry: boxGeometry)

        cube.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y + Float(boxGeometry.height/2), hitResult.worldTransform.columns.3.z)
        
        self.sceneView.scene.rootNode.addChildNode(cube)
    }
}
