//
//  AspectVGrid.swift
//  Learning
//
//  Created by itiw-mac 256 on 12/25/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView> : View  where Item: Identifiable, ItemView: View{
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat,@ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader{ geometry in
            
            let width = calculateWidthThatsFits(noOfItems: items.count, size: geometry.size)
            
            LazyVGrid(columns: [getGridItem(width: width)], spacing: 0){
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func getGridItem(width: CGFloat) -> GridItem{
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func calculateWidthThatsFits(noOfItems: Int, size: CGSize) -> CGFloat{
        
        var noOfCols = 1
        var noOfRows = noOfItems/noOfCols
        
        repeat{
            
            let cellWidth = size.width/CGFloat(noOfCols)
            let cellHeight = cellWidth / aspectRatio
            
            if(cellHeight*CGFloat(noOfRows) < size.height){
                break
            }
            noOfCols = noOfCols+1
            noOfRows = (noOfItems + noOfCols - 1)/noOfCols
            
        }while noOfCols < noOfItems
        
        noOfCols = min(noOfCols, noOfItems)
        
        return size.width/CGFloat(noOfCols)
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
