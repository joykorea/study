//
//  DetectClassifyInterface.h
//  Gesture
//
//  Created by Li,Jiabin on 07/11/2017.
//  Copyright © 2017 Li,Jiabin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT
@interface DetectClassifyInput : NSObject {
    unsigned char *imagePixels; // input image bytes
    int imageHeight; // input image height
    int imageWidth; // input image width
}
@property unsigned char *imagePixels;
@property int imageHeight;
@property int imageWidth;

- (unsigned char *)pixelBRGA32BytesFromImage:(UIImage *)image;
@end

FOUNDATION_EXPORT
@interface KeyRect : NSObject {
    float leftTopX;
    float leftTopY;
    float rightBottomX;
    float rightBottomY;
}
@property float leftTopX;
@property float leftTopY;
@property float rightBottomX;
@property float rightBottomY;
@end

FOUNDATION_EXPORT
@interface DetectClassifyObject : NSObject {
    int category;
    float probability;
    KeyRect *keyRect;
}
@property int category;
@property float probability;
@property KeyRect *keyRect;
@end

FOUNDATION_EXPORT
@interface DetectClassifyOutput : NSObject {
    int num; // Detect result object number
    NSMutableArray *objects; // array of DetectClassifyObject
}
@property int num;
@property NSMutableArray *objects;
@end

FOUNDATION_EXPORT
@interface DetectClassifyInterface : NSObject

+ (DetectClassifyInterface *)sharedInstance;

/*
 function: authorize SDK licence
 parameter:
 - licenceKey
 Authorized key name.
 - path:
 Authorized file path.
 */
- (void)verifyLicenceKey:(NSString *)licenceKey withPath:(NSString *)path;

/*
 function: load model.
 parameter:
 - modelPath:
 if it is a directory we know how to load model files under the path.
 if it is a file path, just load the model directly.
 return value:
 - 0: succeed.
 - -1: failed.
 */
- (int)loadModel:(NSString *)modelPath;

/*
 function: unload model.
 parameter:
 return value:
 */
- (void)unloadModel;

/*
 function: process the input image, and get detect and classify results.
 parameter:
 - image_matrix: image matrix created by ImageMatrix.
 - part_mask: indicate which parts are to be processed.
 - result: all results output here.
 return value:
 - 0: succeed.
 - -1: failed.
 */
- (int)process:(DetectClassifyInput *)input result:(DetectClassifyOutput *)output;
@end
