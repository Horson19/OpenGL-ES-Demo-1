//
//  ViewController.h
//  OpenGL-ES-1
//
//  Created by HorsonChan on 2018/9/28.
//  Copyright © 2018年 Horson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GLKit/GLKit.h>

#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>


@interface ViewController : GLKViewController
{
    EAGLContext *context;
    GLKBaseEffect *effect;
}

@end

