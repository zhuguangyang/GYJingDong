//
//  GYBanner.swift
//  GYBanner
//
//  Created by zhushushu on 16/4/23.
//  Copyright © 2016年 zhushushu. All rights reserved.
//

import UIKit

import SDWebImage



class GYBanner: UIView {
    
    
    var _sv:UIScrollView = UIScrollView()
    var _pgCtrl:UIPageControl = UIPageControl()
    var _leftView:UIImageView  = UIImageView() //左边图片
    var _centerView:UIImageView = UIImageView() //中间图片
    var _rightView:UIImageView = UIImageView() //右边图片
    var _titleLbl:UILabel = UILabel()      //标题
    var _models:Array<GYBannerModel> = []   //装载轮播模型
    var _currIndex:Int = 0
    var _timer:Timer = Timer()
    var _size:CGSize = CGSize()
    
    var _imageHandle:(_ index:Int) -> () = { (index) -> () in
        
        
    }//记录手势点击的图片的下表
    
    
    /**
     实例化轮播
     
     - parameter frame:       轮播图的位置
     - parameter imageHandle: 返回点击手势
     
     - returns: UIView
     */
    func initWithFrame(_ frame:CGRect, imageHandle:@escaping (_ index:Int) -> ()) -> GYBanner{
        
        let viewBgd:GYBanner = GYBanner(frame: frame)
        //记录
        _size = frame.size
        _currIndex = 0
        _imageHandle = imageHandle
        
        //实例化sv
        _sv = UIScrollView(frame: CGRect(x: 0, y: 0, width: _size.width, height: _size.height))
        
        _sv.isPagingEnabled = true
        _sv.bounces = true
        
        _sv.showsHorizontalScrollIndicator = false
        _sv.showsVerticalScrollIndicator = false
        _sv.delegate = self
        // 三屏循环滚动
        _sv.contentSize = CGSize(width: _size.width * 3, height: _size.height )
        
        viewBgd.addSubview(_sv)
        
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(GYBanner.tapHandle))
        
        _sv.addGestureRecognizer(tap)
        
        //标题
        //        _titleLbl = UILabel(frame: CGRect(x: 0, y: CGRectGetMaxY(_sv.frame) - 30, width: _sv.bounds.size.width, height: 30))
        //        _titleLbl.font = UIFont.systemFontOfSize(15)
        //        _titleLbl.textColor = UIColor.whiteColor()
        //        
        //        _titleLbl.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        
        //        viewBgd.addSubview(_titleLbl)
        
        //实例化PageControl
        _pgCtrl = UIPageControl(frame: CGRect(x: _sv.frame.maxX - 100, y: _size.height - 30, width: 80, height: 30))
        _pgCtrl.isEnabled = false
        
        viewBgd.addSubview(_pgCtrl)
        
        return viewBgd
        
    }
    
    /**
     刷新数据模型
     
     - parameter models: 轮播所需数据模型的数组
     */
    func reloadGYBanner(_ models:Array<GYBannerModel>){
        if models.count == 0 {
            return;
        }
        
        _models = models
        
        startTimer()
        
        var model =  GYBannerModel()
        model = _models[_currIndex]
        
        //        _titleLbl.text = model.labelText
        // 点个数
        _pgCtrl.numberOfPages = _models.count
        
        instanceImageView()
        
        
    }
    
    /**
     tap手势
     */
    func tapHandle(){
        
        _imageHandle(_currIndex)
    }
    
    /**
     开启轮播定时器
     */
    func startTimer(){
        
        _timer.invalidate()
        
        _timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(GYBanner.autoScroll), userInfo: nil, repeats: true)
        
    }
    
    
    
    /**
     实例化三张图片
     */
    fileprivate func instanceImageView(){
        
        for i in 0...3{
            let tmpV = _sv.viewWithTag(6666 + i) as UIView!
            
            if tmpV != nil {
                print(tmpV)
            }
            tmpV?.removeFromSuperview()
            
        }
        
        //只有三屏
        for i in 0..<3 {
            
            let imageV = UIImageView(frame: CGRect(x: _size.width * CGFloat(i), y: 0, width: _size.width, height: _size.height))
            imageV.contentMode = UIViewContentMode.scaleToFill
            imageV.tag = 6666 + i
            //            imageV.contentMode = UIViewContentMode.ScaleAspectFill
            imageV.clipsToBounds = true
            _sv.addSubview(imageV)
            
            //最后一张图片
            if i == 0 {
                var model = GYBannerModel()
                model = _models.last!
                imageV.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: UIImage(named: "banner_bg"))
                _leftView = imageV
            } else if i == 1 {
                
                //中间图片  (第一张)
                var model = GYBannerModel()
                model = _models.first!
                imageV.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: UIImage(named: "banner_bg"))
                _centerView = imageV
            } else {
                //右边的图片 (第二张)
                var model = GYBannerModel()
                model = _models[0]
                imageV.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: UIImage(named: "banner_bg"))
                _rightView = imageV
            }
            
        }
        
        //滚动到中间
        _sv.setContentOffset(CGPoint(x: _size.width, y: 0), animated: false) 
        
    }
    
    
    /**
     自动滚屏
     */
    func autoScroll(){
        
        //滚动到下一屏
        _sv.setContentOffset(CGPoint(x: _size.width * 2, y: 0), animated: true)
        
        //重新设置图片
        reloadImageView()
    }
    
    /**
     重新设置图片
     */
    fileprivate func reloadImageView(){
        
        //X的偏移量
        let offsetX:CGFloat = _sv.contentOffset.x
        
        //向左滑动
        if(offsetX > _size.width){
            _currIndex = (_currIndex + 1) % _models.count
            
        } else if offsetX < _size.width {
            //向右滑动
            
            _currIndex = (_currIndex - 1 + _models.count) % _models.count
            
        }
        
        let leftIndex:Int = (_currIndex - 1 + _models.count) % _models.count;
        let rightIndex:Int = (_currIndex + 1) % _models.count;
        
        //重新设置图片
        var model = GYBannerModel()
        model = _models[leftIndex]
        _leftView.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: UIImage(named: "banner_bg"))
        
        model = _models[_currIndex]
        _centerView.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: UIImage(named: "banner_bg"))
        
        model = _models[rightIndex]
        _rightView.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: UIImage(named: "banner_bg"))
    }
    
    func positionView(){
        reloadImageView()
        _pgCtrl.currentPage = _currIndex
        let model = _models[_currIndex]
        
        //        _titleLbl.text = model.labelText
        
        //滚动到中间
        _sv.setContentOffset(CGPoint(x: _size.width, y: 0), animated: false)
    }
    
}

extension GYBanner:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        positionView()
        startTimer()
    }
    
    //当设置setContentOffset且为True时调用，手动拖动不会调用
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        positionView()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        _timer.invalidate() 
    }
    
}
