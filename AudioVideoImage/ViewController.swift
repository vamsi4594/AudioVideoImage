//
//  ViewController.swift
//  AudioVideoImage
//
//  Created by THANIKANTI VAMSI KRISHNA on 12/28/19.
//  Copyright © 2019 THANIKANTI VAMSI KRISHNA. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    var URLReqObj:URLRequest!
    var dataTaskObject:URLSessionDataTask!
    // ***************************** for songs play. audioPlayer() *********************
    @IBOutlet var timerLabel: UILabel!
    var audioPlayer:AVAudioPlayer!
    var songsURLArray:[String]!
    var index = 0
    var songURL:String!
    //************************************************************************************
    
    @IBOutlet var visualEffectView: UIVisualEffectView!
    
    var effect:UIVisualEffect!
    //************************************************************************************
    @IBOutlet var audioView: UIView!
    
    @IBOutlet var posterView: UIImageView!
    
    @IBOutlet var scroolView: UIScrollView!
    
    @IBOutlet var storyLabel: UITextView!
    
    @IBOutlet var actorsLabel: UILabel!
    
    @IBOutlet var directorLabel: UILabel!
    
    var videoURL:String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       effect = visualEffectView.effect
       visualEffectView.effect = nil
       audioView.layer.cornerRadius = 5
      
        
    }
    
    // to get data related to movies
    @IBAction func clickHere(_ sender: UIButton)
    {
        let data = movieDetails(type: "https://www.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")
           
           // for image to display
        let imageUrlArray = data[0]["posters"] as! [String]
        var imageUrlInString = "https://www.brninfotech.com/tws/" + imageUrlArray[0]
        imageUrlInString = imageUrlInString.replacingOccurrences(of: " ", with: "%20")
        let imageUrl = URL(string: imageUrlInString)!

        do {
            let imageInData = try Data(contentsOf: imageUrl)
            posterView.image = UIImage(data: imageInData)
        }catch {
            print("Error")
        }

           // for actors to display
        let actors = data[0]["actors"] as! [String]
        for i in 0..<actors.count
        {
            actorsLabel.backgroundColor = UIColor.white
            actorsLabel.text! = "Actor: \(actors[i])\n"
        }
        
           // for director to display
        let director = data[0]["director"]!
        directorLabel.backgroundColor = UIColor.white
        directorLabel.text = "Director: \(director)"
        
           // for story to display
        let story = data[0]["story"]!
        storyLabel.backgroundColor = UIColor.white
        storyLabel.text = "Story: \(story)"
        
            // for video to play
        let trailer = data[0]["trailers"] as! [String]
        videoURL = "https://www.brninfotech.com/tws/" + trailer[0]
        videoURL = videoURL.replacingOccurrences(of: " ", with: "%20")
        
        
           // for songs to play
        let songs = data[0]["songs"] as! [String]
        songURL = "https://www.brninfotech.com/tws/" + songs[0]
        songURL = songURL.replacingOccurrences(of: " ", with: "%20")
          
    }
    
    
    @IBAction func videoButton(_ sender: UIButton)
    {
        // create a standard AVPlayer to play video
        let player = AVPlayer(url: URL(string: videoURL)!)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true, completion: { player.play()})
    }
    
    @IBAction func audioButton(_ sender: UIButton)
    {
        animateInAudio()
      
        
    }
    
    @IBAction func playButton(_ sender: UIButton)
    {
        //audioPlayer.play()
        // create a standard AVPlayer to play audio
        let player = AVPlayer(url: URL(string: songURL)!)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true, completion: { player.play()})
    }
    
//    @IBAction func pauseButton(_ sender: UIButton)
//    {
//        //audioPlayer.pause()
//
//    }
//
//    @IBAction func stopButton(_ sender: UIButton)
//    {
////        audioPlayer.stop()
////        audioPlayer.currentTime = 0
//    }
    
    
//    @IBAction func previewButton(_ sender: UIButton)
//    {
//        audioPlayer.stop()
//        audioPlayer.currentTime = 0
//        if index == 0
//        {
//            index = songsArray.count-1
//        }else{
//            index -= 1
//        }
//        do{
//                   audioPlayer =  try AVAudioPlayer(contentsOf: URL(string: songsURLArray[index])!)
//                   audioPlayer.prepareToPlay()
//                   audioPlayer.currentTime = 0
//                   timerLabel.text = "\(audioPlayer.currentTime)"
//
//                  // Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(timer) in
//                       self.timerLabel.text = "\(round(self.audioPlayer.currentTime*10)/10)"
//                  // })
//               }
//               catch let error as NSError
//               {
//                   print(error.debugDescription)
//
//               }
//    }
    
    
    
    
//
//    @IBAction func nextButton(_ sender: UIButton)
//    {
//        if index == songsArray.count-1
//        {
//            index = 0
//        }else{
//            index += 1
//        }
//        do{
//            audioPlayer =  try AVAudioPlayer(contentsOf: URL(string: songsURLArray[index])!)
//            audioPlayer.prepareToPlay()
//            audioPlayer.currentTime = 0
//            timerLabel.text = "\(audioPlayer.currentTime)"
//
//           // Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(timer) in
//                self.timerLabel.text = "\(round(self.audioPlayer.currentTime*10)/10)"
//           // })
//        }
//        catch let error as NSError
//        {
//            print(error.debugDescription)
//
//        }
        
// }
    
    @IBAction func audioExit(_ sender: UIButton)
    {
        animateOutAudio()
    }
    func animateInAudio()
      {
          self.view.addSubview(audioView)
          audioView.center = self.view.center
          audioView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
          audioView.alpha = 0
        
          
          UIView.animate(withDuration: 0.3)
          {
            self.visualEffectView.effect = self.effect
            self.audioView.alpha = 1
            self.audioView.transform = CGAffineTransform.identity
          }
      }
    func animateOutAudio()
      {
          UIView.animate(withDuration: 0.3, animations: {
              self.audioView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
              self.audioView.alpha = 0
              self.visualEffectView.effect = nil
          }) { (success:Bool) in
              self.audioView.removeFromSuperview()
              
          }
        
      }
    
     // communicate with server
    func movieDetails(type:String)->[[String:Any]]
    {
           
        var convertedData:[[String:Any]]!
           //requesting to server by URLReqObj
        URLReqObj = URLRequest(url: URL(string: type)!)
           //using GET method/httpMethod
        URLReqObj.httpMethod = "GET"
           //shared instance of URLSession only
        dataTaskObject = URLSession.shared.dataTask(with: URLReqObj,completionHandler: { (data,connDetails,err) in
               
               //error handling
        do{
            //receving data in the JSON format so we have to convert into Swift
            convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:Any]]
            print(convertedData!)
        }catch{
            print("Something Went Wrong")
        } })
           //connecting to server
        dataTaskObject.resume()
               //upto getting data from server will not get nil why because of using this statement
        while(convertedData == nil)
            {
                   
            }
        return convertedData!
       }
    

// end of program
}

