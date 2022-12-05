//
//  ViewController.m
//  DataTest
//
//  Created by robosen on 2022/10/28.
//

#import "ViewController.h"
#import "EasyUtils.h"

@interface ViewController ()

@property (nonatomic,strong) NSMutableData *data;

@property (nonatomic,copy) NSString *res;

@property (nonatomic,copy) NSData *resData;

@property (nonatomic,copy) NSString *hexStr;

@end

@implementation ViewController

- (NSMutableData *)data {
    if(_data == nil){
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark NSData 转 16进制字符串
- (IBAction)nsdataToHexStr:(id)sender {
    NSString *text = @"hello 秦天柱 123!";
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"data:%@",data);
    NSString *hexStr = [EasyUtils convertDataToHexStr:data];
    NSLog(@"16进制字符串: %@",hexStr);
    self.hexStr = hexStr;
}

#pragma mark 16进制字符串 转 字符串
- (IBAction)hexStrToStr:(id)sender {
    self.res = [EasyUtils convertHexStringToString:self.hexStr];
    NSLog(@"字符串:%@",self.res);
}


#pragma mark 字符串 转 16进制字符串
- (IBAction)strToHerStr:(id)sender {
    NSString *hexStr = [EasyUtils convertStringToHexString:self.res];
    NSLog(@"字符串->16进制字符串 :%@",hexStr);
}

#pragma mark 16进制字符串 转 NSData
- (IBAction)herStrToNSData:(id)sender {
    NSData *data = [EasyUtils convertHexStrToData:self.hexStr];
    NSLog(@"16进制 -> data: %@",data);
}


#pragma mark 数据转换
- (IBAction)dataAction:(id)btn {
    //原始数据 0x68 65 6c 6c 6f 20 e7 a7 a6 e5 a4 a9 e6 9f b1 20 31 32 33 21
    //[self saveNumb];
    [self saveStr];

}

#pragma mark 数据读取
- (IBAction)readData:(id)sender {
    


}

// *** 拼接数据 ***

//存储字符串
-(void)saveStr {
    NSInteger a = 108;
    int b = 155;
    NSData *data1 = [EasyUtils convertIntToData:a];
    NSData *data2 = [EasyUtils convertIntToData:b];
//    NSLog(@"a:%@",data1);
//    NSLog(@"b:%@",data2);
    NSMutableData *data = [[NSMutableData alloc] init];
    [data appendData:[data1 subdataWithRange:NSMakeRange(0, 1)]];
    //NSLog(@"data:%@",data);
    NSInteger r1 = [EasyUtils convertDataToInt:data];
    //NSLog(@"a:%ld",r1);
    //
    int c = 188;
    NSString *str = [EasyUtils toHex:c];
    //NSLog(@"str:%@",str);
    NSData *data3 = [EasyUtils convertHexStrToData:str];
   // NSLog(@"ddd:%@",data3);
    [data appendData:data3];
    //
    char bt[] = {0x11,0xaa,0xba};
    
    [data appendBytes:bt length:3];
    //
    NSString *sss = @"hello 111";
    NSData *s1 = [sss dataUsingEncoding:NSUTF8StringEncoding];
    [data appendData:s1];
    //
    NSLog(@"res:%@",data);
    
    //
    Byte *p = (Byte *)[data bytes];
    NSData *d1 = [[NSData alloc] initWithBytes:p length:1];
    NSLog(@"r1:%@",d1);
    p++;
    NSData *d2 = [[NSData alloc] initWithBytes:p length:1];
    NSLog(@"r2:%@",d2);
    p++;
    NSData *d3 = [[NSData alloc] initWithBytes:p length:3];
    NSLog(@"d3:%@",d3);
    //
    p += 3;
    
    NSString *d4 = [[NSString alloc] initWithBytes:p length:s1.length encoding:NSUTF8StringEncoding];
    NSLog(@"字符串:%@",d4);
    
}


// 存储 数字
-(void)saveNumb {
    NSInteger a = 108;
    NSInteger b = 155;
    NSInteger c = 607;
    NSData *data1 = [EasyUtils convertIntToData:a];
    NSData *data2 = [EasyUtils convertIntToData:b];
    NSData *data3 = [EasyUtils convertIntToData:c];
//    NSLog(@"a:%@",data1);
//    NSLog(@"b:%@",data2);
//    NSLog(@"c:%@",data3);
    NSMutableData *data  = [[NSMutableData alloc] init];
    [data appendData:data1];
    [data appendData:data2];
    [data appendData:data3];
//    NSLog(@"data:%@",data);
    //读取
    NSData *r1 = [data subdataWithRange:NSMakeRange(0, 4)];
    NSData *r2 = [data subdataWithRange:NSMakeRange(4, 4)];
    NSData *r3 = [data subdataWithRange:NSMakeRange(8, 4)];
    
//    NSLog(@"a1:%@",r1);
//    NSLog(@"b1:%@",r2);
//    NSLog(@"c1:%@",r3);
    //
    NSInteger a1 = [EasyUtils convertDataToInt:r1];
    NSLog(@"%ld",a1);
  
    
}


-(void)test03 {
    Byte frameHeader[] = {0x68,0x65,0x6c,0x6c,0x6f,0x20,0xe7,0xa7,0xa6,0xe5,0xa4,0xa9,0xe6,0x9f,0xb1,0x20,0x31,0x32,0x33,0x21};
   
    //
    NSMutableData *sendData = [[NSMutableData alloc] init];
    [sendData appendBytes:frameHeader length:20];
    
    NSString *str = [[NSString alloc] initWithData:sendData encoding:NSUTF8StringEncoding];
    
    NSLog(@"字符串:%@",str);
}


-(void)test02 {
    //1. 字符串
     NSString *begin = @"hello world !";
     NSData *bData = [begin dataUsingEncoding:NSUTF8StringEncoding];
     NSLog(@"数据:%@",bData);
     //2.将data 转成 字符串
     NSString *bRes = [[NSString alloc] initWithData:bData encoding:NSUTF8StringEncoding];
     NSLog(@"字符串结果:%@",bRes);
     //3.将16进制数据转 16进制字符串
     NSString *res1 = [self changeToHexStrBy:bData];
     NSLog(@"***16进制字符串 结果***:%@",res1);
     //4. 16进制字符串 转 字符串
     NSString *res2 = [self stringFromHexString:res1];
     NSLog(@"*字符串*:%@",res2);
}

// NSdata 转成 16进制 字符串
-(NSString *)changeToHexStrBy:(NSData *)data
{
    if (!data && ![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    return hexString;
}

//16进制字符串 转 字符串
- (NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

-(void)test01 {
    int a = 1234567890;
    [self.data appendBytes:&a length:4];
    int b = 0;
    [self.data getBytes:&b length:4];
    NSLog(@"%d",b);
    
    NSDictionary *dic = @{@"name":@"张三丰",@"phone":@"18888888",@"address":@"北京市国家会议中心"};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"数据源:%@",data);
    
}

-(void)test1 {
    int a = 10;
    Byte b = a;
    Byte frameHeader[] = {0x12,0x56,0x78,0x35};
    long long timeStamp = (long long)[[NSDate date] timeIntervalSince1970] * 1000;
    //
    NSMutableData *sendData = [[NSMutableData alloc] init];
    [sendData appendBytes:frameHeader length:4];
    [sendData appendBytes:&b length:1];
    //
    unsigned int dataSize = 0;
    dataSize = CFSwapInt32HostToBig(dataSize);
    [sendData appendBytes:&dataSize length:4];
    
    //
    NSLog(@"数据%@",sendData);
    
    self.data = sendData;
}


-(void)res_test1 {
    NSData *data = [self.data subdataWithRange:NSMakeRange(0, 4)];
    
    Byte * a  = (Byte *)data.bytes;
    
    for (int i = 0; i < 4; i++) {
        printf("数组: = %lx \n",a[i]);
    }
    //
    NSData *data1 = [self.data subdataWithRange:NSMakeRange(4, 1)];
    Byte *b = (Byte *)data1.bytes;
    printf("值: %d",*b);
}




@end
