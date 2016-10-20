//
//  Step1ViewController.swift
//  A&D Screening
//
//  Created by Andrew Stallone on 9/5/16.
//  Copyright © 2016 Andrew Stallone. All rights reserved.
//

import UIKit
import AVFoundation

var emotionDictionary:[String: [Float]] = [:]

class Step1ViewController: UIViewController {
    
    //MARK: variables
    
    var dataString = NSString()
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    //MARK: outlets
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //set up capture session once view loads
        
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        captureSession?.sessionPreset = AVCaptureSessionPreset1280x720
        
        //find the front facing camera
        
        guard let frontCam = AVCaptureDevice.devices().filter({ ($0 as AnyObject).position == .front })
            .first as? AVCaptureDevice else {
                fatalError("No front facing camera found")
        }
        let input = try! AVCaptureDeviceInput(device: frontCam)
        
        if  captureSession!.canAddInput(input) {
            print("input added")
            captureSession!.addInput(input)
            
        }
        
        //run session
        captureSession?.startRunning()
        stillImageOutput = AVCaptureStillImageOutput()
        
        stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        captureSession!.addOutput(stillImageOutput)
        //calls the take picture function
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(Step1ViewController.didPressTakePhoto), userInfo: nil, repeats: false)

        // Do any additional setup after loading the view.
        
    }
    
    //MARK: actions
    
    func didPressTakePhoto() {
        print("inside didTakePhoto function")
        if ((self.captureSession?.sessionPreset) != nil) {
            
            let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo)
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(sampleBuffer, error) in
                
                if sampleBuffer != nil{
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let dataProvider = CGDataProvider(data: imageData as! CFData)
                let intent = CGColorRenderingIntent.defaultIntent
                _ = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: intent)
                
                //shows image on the screen
                //let image = UIImage(CGImage: cgImageRef!, scale: 0.9, orientation: UIImageOrientation.Right)
                
                //self.capturedImage.image = image
                print("picture taken ")
                self.upload_request(imageData!)
                
                }else{
                    print("sample buffer not valid")
                }
                
                
            })
        }else{
            print("session not running")
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // uploading the taken picture to the api
    func upload_request(_ imageData: Data)
    {
        //start nsurl request, the values are from the website
        let url:URL = URL(string: "https://api.projectoxford.ai/emotion/v1.0/recognize")!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue("69072359eb954fc798bc543833875810", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        
        
        print("uploaded started processing")
        
        
        var emotions  = [Float]()
        
        
        let task = session.uploadTask(with: request as URLRequest, from: imageData, completionHandler:
            {(data,response,error) in
                
                guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                    print("error")
                    return
                }
               
                print("data returned")
                
                //when no data is returned app crashes ie. cannot find a face
                
                  self.dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                    // print data to debugger
                
                   print(self.dataString)
                    
                
                
                
                
                // parse json using built in functionality
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers)
                    
                    
                    let info : NSArray = ((json as AnyObject).value(forKey: "scores") as! NSArray)
                    
                    
                    if info.count != 0{
                        
                    
                    let anger: Float = (info[0] as AnyObject).value(forKey: "anger") as! Float
                    let contempt: Float = (info[0] as AnyObject).value(forKey: "contempt") as! Float
                    let disgust: Float = (info[0] as AnyObject).value(forKey: "disgust") as! Float
                    let fear: Float = (info[0] as AnyObject).value(forKey: "fear") as! Float
                    let happiness: Float = (info[0] as AnyObject).value(forKey: "happiness") as! Float
                    let neutral: Float = (info[0] as AnyObject).value(forKey: "neutral") as! Float
                    let sadness: Float = (info[0] as AnyObject).value(forKey: "sadness") as! Float
                    let surprise: Float = (info[0] as AnyObject).value(forKey: "surprise") as! Float
                    
                    emotions.append(anger)
                    emotions.append(contempt)
                    emotions.append(disgust)
                    emotions.append(fear)
                    emotions.append(happiness)
                    emotions.append(neutral)
                    emotions.append(sadness)
                    emotions.append(surprise)
                    
                  
                    
                    
                    
                        emotionDictionary = [
                            "anger" : [emotions[0]],
                            "contempt" : [emotions[1]],
                            "disgust" : [emotions[2]],
                            "fear" : [emotions[3]],
                            "happiness" : [emotions[4]],
                            "neutral" : [emotions[5]],
                            "sadness" : [emotions[6]],
                            "surprise" : [emotions[7]]
                        ]


                    
                    }
                    
                    
                    // since the upload is in a seperate thread access the main thread to set the returned data
                    DispatchQueue.main.async {
                        //self.emotionData.text = self.dataString as String
                        //self.emotionData.text.append(self.emotionDictionary["anger"])
                        
                    }
                    
                    
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        );
        
        
    
    
        task.resume()
        
        
    }

    
}
