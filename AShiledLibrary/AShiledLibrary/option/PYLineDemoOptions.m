//
//  PYLineDemoOptions.m
//  iOS-Echarts
//
//  Created by Pluto Y on 9/1/16.
//  Copyright © 2016 pluto-y. All rights reserved.
//

#import "PYLineDemoOptions.h"

@implementation PYLineDemoOptions

+ (PYOption *)standardLineOptionWithXArray:(NSMutableArray *)xArray andYArray:(NSMutableArray *)yArray andVoidYArray:(NSMutableArray *)voidYArray{
    return [PYOption initPYOptionWithBlock:^(PYOption *option) {
        option.backgroundColorEqual([[PYColor alloc]initWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]])
        .tooltipEqual([PYTooltip initPYTooltipWithBlock:^(PYTooltip *tooltip) {
            tooltip.triggerEqual(PYTooltipTriggerAxis);
        }])
        .gridEqual([PYGrid initPYGridWithBlock:^(PYGrid *grid) {
            grid.xEqual(@30).x2Equal(@40).yEqual(@40).y2Equal(@30);
        }])
        .legendEqual([PYLegend initPYLegendWithBlock:^(PYLegend *legend) {
            legend.dataEqual(@[@"运行",@"空跑",@"差值"])
            .xEqual(PYPositionLeft)
            .yEqual(PYPositionTop)
            .zEqual(@101)
            .showEqual(YES);
        }])
        .toolboxEqual([PYToolbox initPYToolboxWithBlock:^(PYToolbox *toolbox) {
            toolbox.showEqual(YES)
            .xEqual(PYPositionRight)
            .yEqual(PYPositionTop)
            .zEqual(@100)
            .featureEqual([PYToolboxFeature initPYToolboxFeatureWithBlock:^(PYToolboxFeature *feature) {
                feature.dataViewEqual([PYToolboxFeatureDataView initPYToolboxFeatureDataViewWithBlock:^(PYToolboxFeatureDataView *dataView) {
                    dataView.showEqual(YES).readOnlyEqual(NO);
                }])
                .restoreEqual([PYToolboxFeatureRestore initPYToolboxFeatureRestoreWithBlock:^(PYToolboxFeatureRestore *restore) {
                    restore.showEqual(YES);
                }]);
            }]);
        }])
        .addXAxis([PYAxis initPYAxisWithBlock:^(PYAxis *axis) {
            axis.typeEqual(PYAxisTypeCategory)
            .boundaryGapEqual(@NO)
            .addDataArr(xArray);
//            .axisLabel.textStyleEqual([PYTextStyle initPYTextStyleWithBlock:^(PYTextStyle *textStyle) {
//                textStyle.colorEqual([[PYColor alloc] initWithColor:[UIColor blueColor]]);
//            }]);
        }])
        .addYAxis([PYAxis initPYAxisWithBlock:^(PYAxis *axis) {
            axis.typeEqual(PYAxisTypeValue)
            .axisLabelEqual([PYAxisLabel initPYAxisLabelWithBlock:^(PYAxisLabel *axisLabel) {
                axisLabel.formatterEqual(@"{value}");
            }]);
        }])
        .addSeries([PYSeries initPYSeriesWithBlock:^(PYSeries *series) {
            series.nameEqual(@"运行")
            .itemStyleEqual([PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
                itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *itemStyleProp) {
                    itemStyleProp.colorEqual([[PYColor alloc] initWithColor:[UIColor orangeColor]]);
                }]);
            }])
            .typeEqual(PYSeriesTypeLine)
            .dataEqual(yArray)
//            .markPointEqual([PYMarkPoint initPYMarkPointWithBlock:^(PYMarkPoint *point) {
//                point.addDataArr(@[@{@"type" : @"max", @"name": @"最大值"}]);
//            }])
            .markLineEqual([PYMarkLine initPYMarkLineWithBlock:^(PYMarkLine *markLine) {
                markLine.addDataArr(@[@{@"type" : @"average", @"name": @"平均值"}]);
                
            }]);
            
        }]);
        if (voidYArray && voidYArray.count) {
            option.addSeries([PYSeries initPYSeriesWithBlock:^(PYSeries *series) {
                series.nameEqual(@"空跑")
                .itemStyleEqual([PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
                    itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *itemStyleProp) {
                        itemStyleProp.colorEqual([[PYColor alloc] initWithColor:[UIColor blueColor]]);
                    }]);
                }])
                .typeEqual(PYSeriesTypeLine)
                .dataEqual(voidYArray)
//                .markPointEqual([PYMarkPoint initPYMarkPointWithBlock:^(PYMarkPoint *point) {
//                    point.addDataArr(@[@{@"type" : @"max", @"name": @"最大值"}]);
//                }])
                .markLineEqual([PYMarkLine initPYMarkLineWithBlock:^(PYMarkLine *markLine) {
                    markLine.addDataArr(@[@{@"type" : @"average", @"name": @"平均值"}]);
                }]);
            }]);
            NSMutableArray *dValueArr = [NSMutableArray array];
            for (int i = 0; i < xArray.count; i++) {
                NSInteger value1 = [yArray[i] integerValue] - [voidYArray[i] integerValue];
                NSNumber *value2 = [NSNumber numberWithInteger:value1];
                [dValueArr addObject:value2];
            }
            option.addSeries([PYSeries initPYSeriesWithBlock:^(PYSeries *series) {
                series.nameEqual(@"差值")
                .itemStyleEqual([PYItemStyle initPYItemStyleWithBlock:^(PYItemStyle *itemStyle) {
                    itemStyle.normalEqual([PYItemStyleProp initPYItemStylePropWithBlock:^(PYItemStyleProp *itemStyleProp) {
                        itemStyleProp.colorEqual([[PYColor alloc] initWithColor:[UIColor greenColor]]);
                    }]);
                }])
                .typeEqual(PYSeriesTypeLine)
                .dataEqual(dValueArr)
                .markPointEqual([PYMarkPoint initPYMarkPointWithBlock:^(PYMarkPoint *point) {
                    point.addDataArr(@[@{@"type" : @"max", @"name": @"最大值"}]);
                }])
                .markLineEqual([PYMarkLine initPYMarkLineWithBlock:^(PYMarkLine *markLine) {
                    markLine.addDataArr(@[@{@"type" : @"average", @"name": @"平均值"}]);
                    
                }]);
            }]);
        }
        
    }];
}

+ (PYOption *)standardLineOption {
    return [PYOption initPYOptionWithBlock:^(PYOption *option) {
        option.titleEqual([PYTitle initPYTitleWithBlock:^(PYTitle *title) {
            title.textEqual(@"未来一周气温变化")
            .subtextEqual(@"纯属虚构");
        }])
        .tooltipEqual([PYTooltip initPYTooltipWithBlock:^(PYTooltip *tooltip) {
            tooltip.triggerEqual(PYTooltipTriggerAxis);
        }])
        .gridEqual([PYGrid initPYGridWithBlock:^(PYGrid *grid) {
            grid.xEqual(@40).x2Equal(@50);
        }])
        .legendEqual([PYLegend initPYLegendWithBlock:^(PYLegend *legend) {
            legend.dataEqual(@[@"最高温度",@"最低温度"])
            .showEqual(NO);
        }])
        .toolboxEqual([PYToolbox initPYToolboxWithBlock:^(PYToolbox *toolbox) {
            toolbox.showEqual(YES)
            .xEqual(PYPositionRight)
            .yEqual(PYPositionTop)
            .zEqual(@100)
            .featureEqual([PYToolboxFeature initPYToolboxFeatureWithBlock:^(PYToolboxFeature *feature) {
                feature.markEqual([PYToolboxFeatureMark initPYToolboxFeatureMarkWithBlock:^(PYToolboxFeatureMark *mark) {
                    mark.showEqual(YES);
                }])
                .dataViewEqual([PYToolboxFeatureDataView initPYToolboxFeatureDataViewWithBlock:^(PYToolboxFeatureDataView *dataView) {
                    dataView.showEqual(YES).readOnlyEqual(NO);
                }])
                .magicTypeEqual([PYToolboxFeatureMagicType initPYToolboxFeatureMagicTypeWithBlock:^(PYToolboxFeatureMagicType *magicType) {
                    magicType.showEqual(YES).typeEqual(@[PYSeriesTypeLine, PYSeriesTypeBar]);
                }])
                .restoreEqual([PYToolboxFeatureRestore initPYToolboxFeatureRestoreWithBlock:^(PYToolboxFeatureRestore *restore) {
                    restore.showEqual(YES);
                }]);
            }]);
        }])
        .addXAxis([PYAxis initPYAxisWithBlock:^(PYAxis *axis) {
            axis.typeEqual(PYAxisTypeCategory)
            .boundaryGapEqual(@NO)
            .addDataArr(@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]);
        }])
        .addYAxis([PYAxis initPYAxisWithBlock:^(PYAxis *axis) {
            axis.typeEqual(PYAxisTypeValue)
            .axisLabelEqual([PYAxisLabel initPYAxisLabelWithBlock:^(PYAxisLabel *axisLabel) {
                axisLabel.formatterEqual(@"{value} ℃");
            }]);
        }])
        .addSeries([PYSeries initPYSeriesWithBlock:^(PYSeries *series) {
            series.nameEqual(@"最高温度")
            .typeEqual(PYSeriesTypeLine)
            .dataEqual(@[@(11),@(11),@(15),@(13),@(12),@(13),@(10)])
            .markPointEqual([PYMarkPoint initPYMarkPointWithBlock:^(PYMarkPoint *point) {
                point.addDataArr(@[@{@"type" : @"max", @"name": @"最大值"},@{@"type" : @"min", @"name": @"最小值"}]);
            }])
            .markLineEqual([PYMarkLine initPYMarkLineWithBlock:^(PYMarkLine *markLine) {
                markLine.addDataArr(@[@{@"type" : @"average", @"name": @"平均值"}]);
            }]);
            
        }])
        .addSeries([PYSeries initPYSeriesWithBlock:^(PYSeries *series) {
            series.nameEqual(@"最低温度")
            .typeEqual(PYSeriesTypeLine)
            .dataEqual(@[@(1),@(-2),@(2),@(5),@(3),@(2),@(0)])
            .markPointEqual([PYMarkPoint initPYMarkPointWithBlock:^(PYMarkPoint *point) {
                point.addDataArr(@[@{@"value" : @(2), @"name": @"周最低", @"xAxis":@(1), @"yAxis" : @(-1.5)}]);
            }])
            .markLineEqual([PYMarkLine initPYMarkLineWithBlock:^(PYMarkLine *markLine) {
                markLine.addDataArr(@[@{@"type" : @"average", @"name": @"平均值"}]);
            }]);
        }]);
    }];
}

@end
