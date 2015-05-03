#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionMenu.h"

@interface WKContentView : UIView
- (NSString *)selectedText;
@end

@implementation UIResponder (GoogleActionChrome)

- (void)doGoogleSearchChrome:(id)sender
{
    NSString *selection = [self selectedTextualRepresentation];
    
    if (selection == nil && [self respondsToSelector:@selector(selectedText)]) {
        selection = [self selectedText];
    }
    
    NSString *text = @"";
    if ([selection length] > 0) {
        text = [selection stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSString *url = @"googlechrome://www.google.com/search?q=";
    
    NSString *keyword = [url stringByAppendingString:text];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:keyword]];
}

- (BOOL)canGoogleSearchChrome:(id)sender
{
	return YES;
}

+ (void)load
{
	id <AMMenuItem> menuItem = [[UIMenuController sharedMenuController]
                                registerAction:@selector(doGoogleSearchChrome:)
                                title:@"GoogleSearch"
                                canPerform:@selector(canGoogleSearchChrome:)];
    
    menuItem.priority = 1000;
    
    if ([UIScreen mainScreen].scale == 1.0f) {
        menuItem.image = [UIImage imageWithContentsOfFile:@"/Library/ActionMenu/Plugins/GSearchChrome.png"];
    } else if ([UIScreen mainScreen].scale == 2.0f) {
        menuItem.image = [UIImage imageWithContentsOfFile:@"/Library/ActionMenu/Plugins/GSearchChrome@2x.png"];
    } else {
        menuItem.image = [UIImage imageWithContentsOfFile:@"/Library/ActionMenu/Plugins/GSearchChrome@3x.png"];
    }
}

@end

