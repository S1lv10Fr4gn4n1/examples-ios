//
//  ViewController.m
//  iBrowserSQLite
//
//  Created by Silvio Fragnani da Silva on 20/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textSQL;
@synthesize commandText;
@synthesize resultText;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [commandText becomeFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextSQL:nil];
    [self setCommandText:nil];
    [self setResultText:nil];
 
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)actionExecute:(id)sender 
{
    ManagerSQLiteSingleton * manager = [ManagerSQLiteSingleton instance];
    
//    [manager executeQuery:@"insert into user (NAME,EMAIL,ACTIVE,PHOTO,USER_UPDATE,DATE_UPDATE,USER_INSERT,DATE_INSERT) values ('Silvio Fragnani da Silva', 'silviofragnanisilva@gmail.com', 1, null,1,current_date,1,current_date)" paramns: nil];
    
    if ([[commandText text]isEqualToString:@""]) {
        return;
    }
    
    const char* error = nil;
    NSArray *resultSet = [manager executeQuery:[commandText text] paramns:nil error:&error];
    
    NSMutableString *s = [[NSMutableString alloc]init];
    for (NSDictionary *dicti in resultSet) {
        [s appendFormat:@"%@",dicti];
    }
    
    if (error) {
        NSMutableString *s = [[NSMutableString alloc]initWithFormat:@"%s", error];
        [resultText setText:s];
    } else if ([s isEqualToString:@""]) {
        [resultText setText:@"no results"];
    } else {
        [resultText setText:s];
    }
    
//    http://www.binpress.com/app/ios-data-grid-table-view/586#features
    
//    [stringCmdText setString: [cmdText text]];
//    
//    NSRange rangeStart = [stringCmdText rangeOfString:cursor options:NSBackwardsSearch];
//    NSRange rangeEnd = [stringCmdText rangeOfString:@"\n" options:NSBackwardsSearch];
//    
//    if ((rangeEnd.location != NSNotFound) && ([stringCmdText length] == (rangeEnd.location +1))) {
//        NSString * stringAux = [self getStringCommand:stringCmdText 
//                                           rangeStart:rangeStart 
//                                             rangeEnd: rangeEnd];
//        
//        SFSCommand * command = [self makeCommand:stringAux];
//        NSString * strResult = [self executeCommand:command];
//        
//        [stringCmdText appendString:strResult];
//        [stringCmdText appendString:cursor];
//        [cmdText setText:stringCmdText];          
//    }

    
}

- (IBAction)actionClean:(id)sender 
{
    [commandText setText:NULL];
    [resultText setText:NULL];
}
@end
