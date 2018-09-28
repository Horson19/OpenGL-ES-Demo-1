//
//  ViewController.m
//  OpenGL-ES-1
//
//  Created by HorsonChan on 2018/9/28.
//  Copyright © 2018年 Horson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置openGL ES
    [self setupOpenGLES];
    //2.加载顶点数据
    [self uploadVertexData];
    //3.加载纹理
    [self uploadTexture];
    
}

//4.回调方法进行渲染
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
    
}


//3.加载纹理
-(void)uploadTexture{
    //1.获取图片纹理地址
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"chilipepper" ofType:@"jpg"];
    //2.设置属性
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1),GLKTextureLoaderOriginBottomLeft, nil];
    //3.加载纹理
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    
    //用着色器加载
    effect = [[GLKBaseEffect alloc]init];
    effect.texture2d0.enabled = GL_TRUE;
    //把上面设置好的纹理给他
    effect.texture2d0.name = info.name;
}


//2.加载顶点数据
-(void)uploadVertexData{
    GLfloat vertexData[] = {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    
    GLuint buffer;
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glGenBuffers(1, &buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
    //开启顶点数据读取
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    //读取顶点数据
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    //开启纹理数据读取
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
    
    
    
}


//1.设置OpenGL ES
-(void)setupOpenGLES{
    context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (!context) {
        NSLog(@"context alloc failed!!!!");
        return;
    }
    GLKView *view = (GLKView *)self.view;
    view.context = context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:context];
    
    glEnable(GL_DEPTH_TEST);
    
}




@end
