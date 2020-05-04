//
//  HomeScreenViewController.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 29.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit
import Charts

class HomeScreenViewController: UIViewController, Covid19APIDelegate, ChartViewDelegate{
   
    
    
    let apiUrl = "https://corona-api.com/countries?include=timeline"
    let globalTimelineUrl = "https://corona-api.com/timeline"
    var covid19Fetcher = Covid19APPI()
    var globalTimelineFetcher = Covid19APPI()
    
    var pieChart = PieChartView()
    var lineChart = LineChartView()
    let slogan  = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        lineChart.delegate = self
        
        covid19Fetcher.url1 = apiUrl
        globalTimelineFetcher.url2 = globalTimelineUrl
        covid19Fetcher.covid19APIDelegate = self
        globalTimelineFetcher.covid19APIDelegate = self
        covid19Fetcher.fetchStatistics()
        globalTimelineFetcher.fetchTimeline()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(pieChart)
        view.addSubview(lineChart)
        drawSlogan()
    }
    
    func fetchedData(_ covid19Data: Covid19Data) {
        DispatchQueue.main.async {
            self.drawPieChart(covid19Data)
            print("critical \(covid19Data.globalCritical ) recovered \(covid19Data.globalRecovered)  confirmed  \(covid19Data.globalConfirmed) deaths  \(covid19Data.globalDeaths)")
        }
    }
    
    func fetchedGlobalTimeline(_ globalTimeline: GlobalTimeline) {
         DispatchQueue.main.async {
            self.drawLineChart(globalTimeline)
        }
    }
    
    func drawPieChart(_ covid19Data: Covid19Data){
        var pieEntries = [PieChartDataEntry]()
        
        pieEntries.append( PieChartDataEntry(value: Double(covid19Data.globalRecovered), label: "Recovered"))
        pieEntries.append( PieChartDataEntry(value: Double(covid19Data.globalDeaths), label: "Deaths"))
        pieEntries.append( PieChartDataEntry(value: Double(covid19Data.globalConfirmed), label: "Confirmed"))
        
        pieEntries.append( PieChartDataEntry(value: Double(covid19Data.globalCritical), label: "Critical"))
        
        let dataSet = PieChartDataSet(entries: pieEntries, label: "COVID-19 Stats")
        let colors = [UIColor.systemGreen, UIColor.systemRed, UIColor.systemYellow, UIColor.systemPurple ]

        dataSet.colors = colors
        pieChart.frame = CGRect(x: 0, y: 0, width: 300, height: 300 )
        pieChart.center = CGPoint(x: 188, y:290)
        pieChart.drawHoleEnabled = false
        pieChart.rotationAngle = 180
        pieChart.noDataText = "loading"
        pieChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        pieChart.chartDescription?.enabled = false
        pieChart.data  = PieChartData(dataSet: dataSet )
    }
    
    func drawLineChart(_ globalTimeline: GlobalTimeline) {
        var lineEntries = [ChartDataEntry]()
        var i = 0
        for x in globalTimeline.data.reversed() {
            i += 1
            lineEntries.append(ChartDataEntry( x:Double(i), y: Double(x.confirmed)))
            print("timeline \(x.confirmed)")
        }
        
        let lineDataSet = LineChartDataSet(entries: lineEntries, label: "Spread Over Time")
        
        lineChart.frame = CGRect(x: 0, y: 0, width: 350, height: 250 )
        lineChart.center = CGPoint(x: 185, y:570)
        lineChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        lineChart.noDataText = "loading"
        lineChart.chartDescription?.text = "Infection Timeline"
        lineChart.chartDescription?.position = CGPoint(x: 220, y: 50)
        lineChart.chartDescription?.textColor = .systemBlue
        lineChart.chartDescription?.font = UIFont(name: "Helvetica", size: 20)!
        lineChart.xAxis.labelPosition = .bottomInside
        lineChart.data  = LineChartData( dataSet: lineDataSet)
    }
    
    func drawSlogan(){
        slogan.frame = CGRect(x: 80, y: 686, width: 230, height: 40)
        slogan.text = "Stay Home, Save Lives!"
        slogan.textAlignment = .center
        slogan.font = UIFont(name: "Helvetica", size: 20)!
        slogan.textColor = .systemBlue
        view.addSubview(slogan)
    }
}
